# iOS-Network-Study
> Study on iOS networking application using URLSession, Alamofire and KingFisher

## 1. URLSession
> URLSession은 Apple의 Foundation framework에 포함된 클래스로, 표준 인터넷 프로토콜을 사용해 URL과 통신할 수 있는 API를 제공합니다. 

### > Example
Apple ITunes에서 30초 프리뷰 음원을 다운받고 재생할 수 있는 간단한 음악 플레이어 앱을 개발합니다.

### > KapiTranslation
다국어 번역 처리 기술을 적용한 텍스트 번역 REST API를 호출해 문장을 번역하는 간단한 번역기 앱을 개발합니다.

* 다국어 번역 기능 구현
* Adaptive Layout 적용

### > KapiVision
Alamofire로 개발한 멀티태그 생성 앱을 URLSession 사용 버전으로 리팩토링합니다.

* 멀티태그 생성 기능 구현
* Adaptive Layout 적용


## 2. Alamofire
> Alamofire는 swift를 기반으로 한 HTTP 통신 라이브러리입니다. Apple의 Foundation networking 기반으로 인터페이스를 제공합니다.

### > Example
Star Wars API에서 영화 내의 우주선 정보를 검색해 나타내주는 앱을 개발합니다.

### > KapiTranslation(Alamofire)
URLSession으로 개발한 번역기 앱을 Alamofire 사용 버전으로 리팩토링합니다.

* 다국어 번역 기능 구현
* Adaptive Layout 적용

### > KapiVision(Alamofire)
멀티태그 생성 REST API를 호출해 업로드한 이미지에 대한 태그를 생성해주는 앱을 개발합니다.

* 멀티태그 생성 기능 구현
* Adaptive Layout 적용


## 3. KingFisher
> KingFisher는 웹에서 이미지를 다운로드하고 캐싱할 수 있는 swift 기반 라이브러리입니다.

### +) Codable
> Codable은 Swift의 Encodable 프로토콜과 Decodable 프로토콜을 모두 준수하는 타입으로, JSON과 같은 외부 데이터를 swift 커스텀 타입과 호환할 수 있게 만듭니다.
