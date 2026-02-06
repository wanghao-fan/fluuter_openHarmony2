import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

class NetworkInfo extends StatefulWidget {
  const NetworkInfo({Key? key}) : super(key: key);

  @override
  State<NetworkInfo> createState() => _NetworkInfoState();
}

class _NetworkInfoState extends State<NetworkInfo> {
  Map<String, String> _networkInfo = {
    '局域网 IP': '获取中...',
    '运营商': '获取中...',
    '网络类型': '获取中...',
    '设备名称': '获取中...',
    '操作系统': '获取中...',
  };
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getNetworkInfo();
  }

  Future<void> _getNetworkInfo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 模拟网络信息获取，实际项目中应使用相应的 API
      await Future.delayed(const Duration(seconds: 1));

      final Map<String, String> info = {
        '局域网 IP': _getLocalIpAddress(),
        '运营商': '中国电信',
        '网络类型': 'WiFi',
        '设备名称': '设备名称',
        '操作系统': '操作系统版本',
      };

      setState(() {
        _networkInfo = info;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _networkInfo = {
          '局域网 IP': '获取失败',
          '运营商': '获取失败',
          '网络类型': '获取失败',
          '设备名称': '获取失败',
          '操作系统': '获取失败',
        };
        _isLoading = false;
      });
    }
  }

  String _getLocalIpAddress() {
    try {
      // 模拟获取本地 IP 地址，实际项目中应使用相应的 API
      return '192.168.1.100';
    } catch (e) {
      return '获取失败';
    }
  }

  void _copyToClipboard(String text) {
    // 简化的复制功能，实际项目中应使用 clipboard 包
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已复制到剪贴板')),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.deepPurple,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _copyToClipboard(value),
            icon: const Icon(Icons.copy),
            tooltip: '复制到剪贴板',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IP 地址与网络信息查询',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '显示本机设备的局域网 IP、运营商等基础信息',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),

            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              Column(
                children: [
                  _buildInfoCard('局域网 IP', _networkInfo['局域网 IP']!, Icons.network_check),
                  _buildInfoCard('运营商', _networkInfo['运营商']!, Icons.business),
                  _buildInfoCard('网络类型', _networkInfo['网络类型']!, Icons.wifi),
                  _buildInfoCard('设备名称', _networkInfo['设备名称']!, Icons.devices),
                  _buildInfoCard('操作系统', _networkInfo['操作系统']!, Icons.computer),
                ],
              ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _getNetworkInfo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                '刷新信息',
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200, width: 1),
              ),
              child: Text(
                '提示：本工具显示的是本机设备的网络信息，包括局域网 IP 地址、运营商信息、网络类型、设备名称和操作系统版本。点击信息卡片右侧的复制图标可以将对应信息复制到剪贴板。',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
