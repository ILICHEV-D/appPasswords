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
        static let sign = "Создать"
        static let error = "Ошибка"
        static let errorDescription = "Заполните пустые поля"
        static let ok = "Хорошо"
        static let login = "Логин"
        static let password = "Пароль"
        static let name = "Название"
        static let newPassword = "Новый пароль"
    }
    
    enum Setting {
        static let showKey = "Показать ключ"
        static let changeKey = "Изменить ключ"
        static let exit = "Выход"
        static let key = "Ключи шифрования"
        static let keyDescriotion = "Если вы потеряете телефон, то при повторной авторизации ваш ключ будет сброшен. Восстановить доступ к паролям вы сможете только введя данные ключи на новом устройстве. Храните их в надежном месте."
        static let changeKeyDescriotion = "Менять ключи стоит только в случае авторизации с нового устройства. Если данным ключом возпроизводилось шифрование паролей, то обзяательно запишите ключ. Будьте внимательны."
        static let buttonChange = "Изменить"
        
        enum Alert {
            static let error = "Ошибка"
            static let messageEmpty = "Вы оставили пустые поля или ввели слишком большое число"
        }

    }
}
