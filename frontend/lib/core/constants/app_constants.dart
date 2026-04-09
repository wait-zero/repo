import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'WaitZero';
  static const int defaultUserId = 1; // 데모용

  // 혼잡도 색상
  static const Color congestionLow = Color(0xFF4CAF50);
  static const Color congestionMedium = Color(0xFFFF9800);
  static const Color congestionHigh = Color(0xFFF44336);

  // 혼잡도 라벨
  static const Map<String, String> congestionLabels = {
    'LOW': '여유',
    'MEDIUM': '보통',
    'HIGH': '혼잡',
  };

  static Color congestionColor(String level) {
    switch (level) {
      case 'LOW':
        return congestionLow;
      case 'MEDIUM':
        return congestionMedium;
      case 'HIGH':
        return congestionHigh;
      default:
        return Colors.grey;
    }
  }

  // 신청 상태 색상
  static const Map<String, Color> statusColors = {
    'PENDING': Colors.grey,
    'CONFIRMED': Color(0xFF1976D2),
    'COMPLETED': Color(0xFF4CAF50),
    'CANCELLED': Color(0xFFF44336),
  };

  static const Map<String, String> statusLabels = {
    'PENDING': '대기중',
    'CONFIRMED': '확인됨',
    'COMPLETED': '완료',
    'CANCELLED': '취소됨',
  };
}
