
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	//Вставить содержимое обработчика
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбновитьДоступностьПоКлиенту(); 
	Элементы.СписокЗадач.ПоложениеСтрокиПоиска = ПоложениеСтрокиПоиска.ЗаголовокФормы;
	//Элементы.СписокЗадач.ПоложениеСтрокиПоиска = ПоложениеСтрокиПоиска.Нет;
КонецПроцедуры

&НаКлиенте
Процедура Добавить(Команда)                       
	ОткрытьФормуИзмененияОписанияЗадачи("");
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуИзмененияОписанияЗадачи(ТекстЗадачи,Ссылка = Неопределено)	
	Оповещение = Новый ОписаниеОповещения("ОбработатьДобавлениеОписаниеЗадачи", ЭтотОбъект,Ссылка);
	ПоказатьВводСтроки(Оповещение,ТекстЗадачи, "Описание", 0, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьДобавлениеОписаниеЗадачи(ТекстЗадачи, ДополнительныеПараметры) Экспорт 
	Если НЕ ((ТекстЗадачи = "" И ДополнительныеПараметры = Неопределено) ИЛИ ТекстЗадачи = Неопределено) Тогда
		СоздатьИзменитьПланируемуюЗадачу(ТекстЗадачи,ДополнительныеПараметры);
		ПолучитьЗаписиПоКлиенту(); 
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СоздатьИзменитьПланируемуюЗадачу(ОписаниеЗадачи = "", Ссылка = Неопределено, Удалить = Ложь)
	Если Ссылка = Неопределено Тогда
		Запись = Справочники.ПланируемыеЗадачи.СоздатьЭлемент();
		Запись.Клиент = Клиент;
	Иначе
		Запись = Ссылка.ПолучитьОбъект();
	КонецЕсли;
	Если Удалить Тогда
		Запись.Удалить();
	Иначе	
		Запись.ОписаниеЗадачи = ОписаниеЗадачи;
		Запись.Записать();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция ПолучитьЗаписиПоКлиенту()
	
	Запрос = Новый запрос("ВЫБРАТЬ
	|	ПланируемыеЗадачи.ОписаниеЗадачи КАК ОписаниеЗадачи,
	|	ИСТИНА КАК Удалить,
	|	ИСТИНА КАК ПревратитьВЗадачу,
	|	ПланируемыеЗадачи.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ПланируемыеЗадачи КАК ПланируемыеЗадачи
	|ГДЕ
	|	ПланируемыеЗадачи.Клиент = &Клиент");
	Запрос.УстановитьПараметр("Клиент",Клиент); 
	СписокЗадач.Загрузить(Запрос.Выполнить().Выгрузить());
	
КонецФункции	

&НаКлиенте
Процедура СписокЗадачВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Строка = Элементы.СписокЗадач.ТекущиеДанные;
	Если Поле.Имя = "СписокЗадачОписаниеЗадачи" Тогда
		ОткрытьФормуИзмененияОписанияЗадачи(Строка.ОписаниеЗадачи,Строка.Ссылка);
	ИначеЕсли Поле.Имя = "СписокЗадачУдалить" Тогда
		СоздатьИзменитьПланируемуюЗадачу(,Строка.Ссылка,Истина);
		ПолучитьЗаписиПоКлиенту();
	ИначеЕсли Поле.Имя = "СписокЗадачПревратитьВЗадачу"	Тогда
		сообщить(2); 		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КлиентПриИзменении(Элемент)
	Если НЕ Клиент.Пустая() Тогда
		ПолучитьЗаписиПоКлиенту();
	КонецЕсли;
	ОбновитьДоступностьПоКлиенту();
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДоступностьПоКлиенту()
	Элементы.СписокЗадач.Доступность = НЕ Клиент.Пустая();
	Элементы.ФормаДобавить.Доступность = НЕ Клиент.Пустая();
КонецПроцедуры

&НаКлиенте
Процедура Настройки(Команда)
	ОткрытьФорму("ОбщаяФорма.Настройки");
КонецПроцедуры
