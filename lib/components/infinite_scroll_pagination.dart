import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InfiniteScrollPaginationComponent extends StatefulWidget {
  const InfiniteScrollPaginationComponent({Key? key}) : super(key: key);

  @override
  _InfiniteScrollPaginationComponentState createState() => _InfiniteScrollPaginationComponentState();
}

class _InfiniteScrollPaginationComponentState extends State<InfiniteScrollPaginationComponent> {
  static const _pageSize = 10;
  final PagingController<int, String> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _simulateApiCall(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<List<String>> _simulateApiCall(int pageKey, int pageSize) async {
    // 模拟网络请求延迟
    await Future.delayed(Duration(seconds: 1));
    
    // 生成模拟数据
    final List<String> items = [];
    for (int i = pageKey; i < pageKey + pageSize; i++) {
      items.add('Item ${i + 1}');
    }
    
    return items;
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, String>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<String>(
        itemBuilder: (context, item, index) {
          return GestureDetector(
            onTap: () {
              // 点击项时的交互效果
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You tapped $item'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                item,
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
        firstPageErrorIndicatorBuilder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading data'),
                ElevatedButton(
                  onPressed: () => _pagingController.refresh(),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        },
        newPageErrorIndicatorBuilder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading more data'),
                ElevatedButton(
                  onPressed: () => _pagingController.retryLastFailedRequest(),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          return Center(
            child: Text('No items found'),
          );
        },
        noMoreItemsIndicatorBuilder: (context) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('No more items'),
            ),
          );
        },
      ),
    );
  }
}
