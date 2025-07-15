# 🚆 Flutter 기차 예매 UI 앱

Flutter로 제작된 기차 예매 인터페이스 앱입니다.  
출발역과 도착역을 선택하고 좌석을 예매하는 기본적인 UI 플로우를 제공합니다.  
다크모드 지원과 예외 처리 로직도 포함되어 있으며, Provider를 통해 테마 상태를 관리합니다.

---

## 📱 주요 기능

| 기능 | 설명 |
|------|------|
| ✅ 출발/도착역 선택 | 리스트에서 역 선택, 동일 역 선택 방지 처리 포함 |
| ✅ 좌석 선택 UI | 좌우 열 구분(A~D), 선택 시 색상 변화, 예매 완료 다이얼로그 |
| ✅ 좌석 중복 선택 방지 | 출발역 = 도착역일 경우 선택 불가 (UI 차단) |
| ✅ 예매 완료 팝업 | 예매 시 AlertDialog로 완료 메시지 표시 후 홈으로 이동 |
| ✅ 다크모드 지원 | Provider + ThemeData 구성으로 토글 지원 |

---

## 🎨 기술 스택

- **Flutter**
- **Provider** (상태 관리: 테마 전용)
- **Material Design**
- **Custom ThemeData**

---

## 🚀 실행 방법

1. Flutter 프로젝트 클론

```bash
git clone <repository-url>
cd flutter-train-reservation





