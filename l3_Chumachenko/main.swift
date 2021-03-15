//
//  main.swift
//  l3_Chumachenko
//
//  Created by Александр Чумаченко on 11.03.2021.
//

import Foundation

///Создай легковой автомобиль 🏎
struct Car {
    private let make: String
    private let model: String
    private let color: Color
    private var turbocharger: Bool
    private var power: UInt
    private var stockPower: UInt
    private var odometer: Double
    private let fuelType: FuelType
    private var transmission: Transmission {
        willSet{
            switch transmission {
            case .manual:
                print("Новый тип кпп - \(newValue.rawValue)")
            case .automatic:
                print("Новый тип кпп - \(newValue.rawValue)")
            case .robot:
                print("Новый тип кпп - \(newValue.rawValue)")
            case .variator:
                print("Новый тип кпп - \(newValue.rawValue)")
            }
        }
        didSet{
            switch transmission {
            case .manual:
                print("Старый тип кпп - \(oldValue.rawValue)")
            case .automatic:
                print("Старый тип кпп - \(oldValue.rawValue)")
            case .robot:
                print("Старый тип кпп - \(oldValue.rawValue)")
            case .variator:
                print("Старый тип кпп - \(oldValue.rawValue)")
            }
        }
    }
    private var engineStatus: EngineStatus {
        willSet{
            if newValue == .on {
                print("Вы запускаете двигатель")
            } else {
                print("Вы выключаете двигатель")
            }
        }
        didSet{
            if oldValue == .off {
                print("Вы успешно запустили двигатель")
            } else {
                print("Вы успешно заглушили двигатель")
            }
        }
    }
    
    //    иниты
    init(make: String, model: String, color: Color, power: UInt, turbocharger: Bool, odometer: Double, fuelType: FuelType, transmission: Transmission) {
        self.make = make
        self.model = model
        self.color = color
        self.power = power
        self.turbocharger = turbocharger
        self.odometer = odometer
        self.fuelType = fuelType
        self.transmission = transmission
        engineStatus = .off
        stockPower = power
    }
    
    //    перечисления
    enum CarInfoMod {
        case fullInfo
        case onlyTechInfo
        case onlyNoTechInfo
        case onlyEngineStatus
    }
    enum FuelType: String {
        case diesel = "Дизель", gas = "Бензин", electric = "Электрический"
    }
    
    enum Transmission: String {
        case manual = "Механика"
        case automatic = "Автомат"
        case robot = "Роботизированная"
        case variator = "Вариатор"
    }
    
    enum EngineStatus: String {
        case on = "Двигатель запущен", off = "Двигатель не запущен"
    }
    
    enum Color: String {
        case black = "black"
        case darkGray = "dark Gray"
        case lightGray = "light Gray"
        case white = "white"
        case gray = "gray"
        case red = "red"
        case green = "green"
        case blue = "blue"
        case darkBlue = "dark blue"
        case cyan = "cyan"
        case yellow = "yellow"
        case magenta = "magenta"
        case orange = "orange"
        case purple = "purple"
        case brown = "brown"
    }
    
    enum TuningStage {
        case stage1, stage2, stage3, stock
    }
    
    //    функции
    /**
     Функция выводит информацию об автомобиле в четырех вариациях
     ~~~
     .fullInfo - выводит полную информацию об автомобиле
     .onlyTechInfo - выводит только техническую информацию об автомобиле
     .onlyNoTechInfo - выводит только основную информацию об авто, исключая техническую
     .onlyEngineStatus - выводит только инфу о том, запущен ли двигатель
     */
    func printCarInfo(mode: CarInfoMod) {
        switch mode {
        case .fullInfo:
            print("-------------------------")
            print("Марка автомобиля - \(self.make)")
            print("Модель автомобиля - \(self.model)")
            print("Цвет - \(self.color.rawValue)")
            print("Пробег - \(self.odometer) км")
            print("Тип двигателя - \(self.fuelType.rawValue)")
            print("Наличие турбины: \(turbocharger ? "Да": "Нет")")
            print("Мощность - \(self.power) л.с.")
            print("КПП - \(self.transmission.rawValue)")
            print("Состояние двигателя - \(self.engineStatus.rawValue)")
            print("-------------------------")
        case .onlyEngineStatus:
            print("-------------------------")
            print("Состояние двигателя - \(self.engineStatus.rawValue)")
            print("-------------------------")
        case .onlyTechInfo:
            print("-------------------------")
            print("Тип двигателя - \(self.fuelType.rawValue)")
            print("Наличие турбины: \(turbocharger ? "Да": "Нет")")
            print("Мощность - \(self.power) л.с.")
            print("КПП - \(self.transmission.rawValue)")
            print("Состояние двигателя - \(self.engineStatus.rawValue)")
            print("-------------------------")
        case .onlyNoTechInfo:
            print("-------------------------")
            print("Марка автомобиля - \(self.make)")
            print("Модель автомобиля - \(self.model)")
            print("Цвет - \(self.color.rawValue)")
            print("Пробег - \(self.odometer) км")
            print("-------------------------")
        }
    }
    
    /**
     Переключает тумблер зажигания
     ~~~
     Позволяет запускать и глушить двигатель
     ~~~
     - Parameter tumblerPosion: Отвечает за положение тумблера вкл/выкл
     */
    mutating func engineTumbler(tumblerPosion: EngineStatus) {
        if tumblerPosion == engineStatus {
            print("Тумблер уже в этом положении")
        } else{
            engineStatus = tumblerPosion
        }
    }
    
    /**
     Функция замены коробки переключения передач (кпп).
     ~~~
     .manual: механическая кпп
     .automat: автоматическая кпп
     .robot: роботизированная кпп
     .variator: вариатор
     ~~~
     
     - Parameter transmission: выбор типа трансмиссии.
     */
    mutating func changeTransmissionType(newTransmissionType transmission: Transmission) {
        if self.transmission == transmission {
            print("Данный тип кпп уже установлен")
        } else {
            self.transmission = transmission
        }
    }
    
    /**
     Функция позволяет добавить мощности твоему авто
     ~~~
     stage1 - городской вариант
     stage2 - полупрофи
     stage3 - вариант для самых решительных
     stock - если тебе всё надоело и ты хочешь откатить весь тюнинг
     ~~~
     - Parameter stage: выбор стэйджа тюнинга
     */
    mutating func tuning(stage: TuningStage) {
        switch stage {
        case .stage1:
            switch turbocharger {
            case false:
                turbocharger = true
                print("Установка турбо комплекта")
            case true:
                print("Замена турбины на более производительную")
            }
            power = stockPower + UInt(Double(stockPower)*0.3)
        case .stage2:
            power = stockPower + UInt(Double(stockPower)*0.5)
        case .stage3:
            power = stockPower + UInt(Double(stockPower)*1.5)
        case .stock:
            power = stockPower
        }
    }
    
    ///Функция позволяет зафиксировать новый пробег твоего авто, при этом запрещено скручивать пробег.
    mutating func odometerNewValue(km: Double) {
        if km > odometer {
            odometer = km
            print("Зафиксирован новый пробег на одометре - \(km) км")
        } else {
            print("Ты правда пытаешься скрутить пробег?")
            sleep(2)
            print("Увы, но мы против скручивания пробегов =(")
        }
    }
}

var myCar = Car(make: "Toyota", model: "Chaser", color: .darkBlue, power: 450, turbocharger: true, odometer: 125_000, fuelType: .gas, transmission: .automatic)

//myCar.printCarInfo(mode: .onlyEngineStatus)
//myCar.engineTumbler(tumblerPosion: .on)
//myCar.printCarInfo(mode: .onlyEngineStatus)
//myCar.engineTumbler(tumblerPosion: .on)
//myCar.printCarInfo(mode: .onlyEngineStatus)
//myCar.changeTransmissionType(newTransmissionType: .manual)
//myCar.printCarInfo(mode: .onlyTechInfo)
//myCar.changeTransmissionType(newTransmissionType: .manual)
//myCar.printCarInfo(mode: .onlyTechInfo)
//myCar.odometerNewValue(km: 126000.5)
//myCar.odometerNewValue(km: 60000)
//myCar.printCarInfo(mode: .onlyTechInfo)
//myCar.tuning(stage: .stage1)
//myCar.printCarInfo(mode: .onlyTechInfo)
//myCar.tuning(stage: .stage2)
//myCar.printCarInfo(mode: .onlyTechInfo)
//myCar.tuning(stage: .stage3)
//myCar.printCarInfo(mode: .onlyTechInfo)
//myCar.tuning(stage: .stock)
//myCar.printCarInfo(mode: .onlyTechInfo)

///Создай свой грузовой автомобиль 🛻
struct Truck {
    ///Марка авто
    private let make: String
    ///Модель авто
    private let model: String
    ///Максимальная грузоподъемность багажника (кг)
    private let trunkOverVolume: Double
    ///Данные на одометре (пробег)
    private var odometer: Double
    ///текущая загруженность багажника (кг)
    private var trunkVolume: Double
    ///Состояние окна (открыто/закрыто)
    private var windowsCondition: WindowSwitch
    
    
    init(make: String, model: String, odometer: Double, trunkVolume: Double) {
        self.make = make
        self.model = model
        self.odometer = odometer
        trunkOverVolume = trunkVolume
        self.trunkVolume = 0
        windowsCondition = .close
    }
    
    enum WindowSwitch {
        case open, close
    }
    
    /// Вывести информацию об автомобиле в консоль
    func printTruckInfo() {
        print("-------------------------")
        print("Марка автомобиля - \(make)")
        print("Модель автомобиля - \(model)")
        print("Пробег - \(odometer) км")
        print("Багажник загружен на \(trunkVolume) кг. из \(trunkOverVolume) кг.")
        print("-------------------------")
    }
    
    /**
     Положить в багажник n - килограмм
     ~~~
     Функция позволяет добавить в багажник нужное кол-во кг.
     ~~~
     - Parameter kg: Укажи вес в килограммах
     */
    mutating func putInTruck (kg: Double) {
        if self.trunkVolume + kg >= 0 && self.trunkVolume + kg <= self.trunkOverVolume {
            self.trunkVolume += kg
        } else {
            print("В багажнике твоего \(make) \(model) не может быть больше \(trunkOverVolume) кг.,\nУпакуем только то, что влезет.")
            trunkVolume = trunkOverVolume
        }
    }
    
    /**
     Изъять из багажника n - килограмм
     ~~~
     Функция позволяет  изъять из багажника нужное кол-во кг.
     ~~~
     - Parameter kg: Укажи вес в килограммах
     */
    mutating func removeFromTruck (kg: Double) {
        if self.trunkVolume + kg >= 0 && self.trunkVolume + kg <= self.trunkOverVolume {
            self.trunkVolume -= kg
        } else {
            print("Ты не можешь вытащить из багажника больше, чем там сейчас есть.\nТак что я вытащил всё что было.")
            trunkVolume = 0
        }
    }
    
    ///Функция позволяет зафиксировать новый пробег твоего авто, при этом запрещено скручивать пробег.
    mutating func odometerNewValue(km: Double) {
        if km > odometer {
            odometer = km
            print("Зафиксирован новый пробег на одометре - \(km) км")
        } else {
            print("Увы, но мы против скручивания пробегов =(")
        }
    }
    
    ///Функция для открытия/ закрытия окон в авто
    mutating func switchWindowMode (_ mode: WindowSwitch) {
        switch mode {
        case .open:
            if windowsCondition == .open {
                print("Окна уже открыты\n")
            } else {
                windowsCondition = .open
                print("Окна открыты\n")
            }
        case .close:
            if windowsCondition == .close {
                print("Окна уже закрыты\n")
            } else {
                windowsCondition = .close
                print("Окна закрыты\n")
            }
        }
    }
}

var myTtuck = Truck(make: "Ford", model: "F-150", odometer: 360000, trunkVolume: 600)
myTtuck.putInTruck(kg: 690)
myTtuck.printTruckInfo()
myTtuck.removeFromTruck(kg: 610)
myTtuck.printTruckInfo()
myTtuck.switchWindowMode(.open)
myTtuck.switchWindowMode(.open)
