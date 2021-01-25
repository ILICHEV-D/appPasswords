import Foundation

enum Localization {
    enum TabBar {
        static let password = "Пароли"
        static let add = "Добавить"
        static let setting = "Настройки"
    }
    
    enum Password {
        static let buttonDelete = "Удалить"
    }
    
    enum Add {
        static let sign = "Записать"
    }
    
    enum Setting {
        static let showKey = "Показать ключ"
        static let changeKey = "Изменить ключ"
        static let key = "Ключи"
        static let buttonChange = "Изменить"
        
        enum Alert {
            static let error = "Ошибка"
            static let messageEmpty = "Вы оставили пустые поля"
        }

    }
}
