# Automatic Reference Counting
- 메모리 사용 추적 및 관리
- 클래스 인스턴스들이 더 이상 사용되지 않을 때 자동으로 메모리 해제
- 메모리를 관리하기 위해 코드들의 관계 정보를 요구함
- Reference count는 class에서만 적용, struct는 value type

> How ARC Works

클래스의 인스턴스를 만들면 그 인스턴스의 정보를 저장하는 메모리가 할당된다. 이 메모리는 인스턴스의 타입에 대한 정보와 저장된 프로퍼티들의 값을 같이 가지고 있다.
추가적으로, 추가적으로 인스턴스가 더 이상 필요하지 않은 경우 ARC는 다른 목적으로 사용할 수 있도록 메모리를 해제한다. 그러나 ARC가 샤용 중인 인스턴스를 해제한 경우 더 이상 인스턴스의 프로퍼티에 접근하거나 메서드를 호출할 수 없게 된다. 게다가 만약 인스턴스에 접근을 시도하는 경우, 앱이 충돌나게 된다.
필요한 인스턴스를 해제시키지 않기 위해 ARC는 클래스 인스턴스에 프로퍼티, 상수, 변수들이 얼마나 사용되고 있는지 추적한다. 만약 하나라도 실행되고 있다면 ARC는 인스턴스를 해제시키지 않는다. 추적을 가능하게 하기 위해 인스턴스가 프로퍼티, 상수, 변수에 할당 될 때 마다 해당 프로퍼티, 상수, 변수가 인스턴스에 대해 'strong reference' 즉, 강한 참조를 하게 한다. strong reference는 메모리 해제를 하지 않게 한다.

> ARC in Action

```swift
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
```
Person class with constant property called name

```swift
var reference1: Person?
var reference2: Person?
var reference3: Person?
```
references automatically initialized with a value of nil
현재는 Person 인스턴스를 참조하지 않음

```swift
reference1 = Person(name: "John Appleseed")
// Prints "John Appleseed is being initialized"
```
하나의 변수에 인스턴스를 할당해줌
strong reference from reference1 to new Person instance

```swift
reference2 = reference1
reference3 = reference1
```
now 3 strong references

```swift
reference1 = nil
reference2 = nil
```
만약 original reference를 포함해서 두 개의 strong reference를 nil로 해제해버리면 하나의 strong reference만 남게된다.

> Strong Reference Cycles Between Class Instances

클래스의 인스턴스가 절대 zero strong reference를 갖지 않게 코드를 작성할 수 있는데 두 개의 클래스 인스턴스가 서로 strong reference를 하고 있을 때 가능하다. 이를 strong reference cycle이라 한다. 이런 strong reference cycle을 해결하기 위해 strong reference 대신 weak이나 unowned reference로 정의한다.

```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
```
Person class는 apartment 프로퍼티를 옵셔널로 갖고 Apartment class는 tenant 프로퍼티를 옵셔널로 갖는다.

```swift
var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
```
두 변수를 옵셔널로 선언한 뒤 새로운 인스턴스 변수로 할당한다.

![](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/referenceCycle01_2x.png)
두 strong reference를 보면 위의 그림과 같다.
