﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ИспользоватьЦеныНаПунктыЗадач = Константы.ИспользоватьЦеныНаПунктыЗадач.Получить();
	ИспользоватьЦеныЗадач = Константы.ИспользоватьЦеныЗадач.Получить();
	ОбновитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура КонстантыПриИзменении(Элемент)
	УстановитьЗначениеКонстанты(Элемент.Имя, ЭтаФорма[Элемент.Имя]);
	ОбновитьВидимость();
КонецПроцедуры

&НаСервере
Процедура УстановитьЗначениеКонстанты(ИмяКонстанты, ЗначениеКонстанты)
	Константы[ИмяКонстанты].Установить(ЗначениеКонстанты);
КонецПроцедуры

&НаСервере
Процедура ОбновитьВидимость()
	Элементы.ИспользоватьЦеныНаПунктыЗадач.Доступность = ИспользоватьЦеныЗадач;
	ИспользоватьЦеныНаПунктыЗадач = ?(ИспользоватьЦеныЗадач,ИспользоватьЦеныНаПунктыЗадач,Ложь);
КонецПроцедуры	