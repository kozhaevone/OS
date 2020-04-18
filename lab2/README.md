## Лабораторная работа №2  

*ФИО* - Кожаев Дмитрий Алексеевич  
*Группа* - ББСО - 01 - 18  

**Лабораторная работа состоит из 3-х частей:**  
- *Задание 1:* настройка работоспособной системы с использованием lvm, raid  
- *Задание 2:* эмуляция отказа одного из дисков  
- *Задание 3:* замена дисков на лету, с добавлением новых дисков и переносом разделов  

# Задание 1
1. Устанавливаем и настраиваем новую ОС. Далее начинаем установку Linux и доходим до меню с информацией о дисках.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/1.Start%20the%20installation.png)  
2. Создаем таблицу разделов на каждом диске и выделяем место для /boot размером 512М.    
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/2.Rzdelenie_diskov.png)
3. Указали место для RAID.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/3.memory.png)  
4. Настраиваем RAID.
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/4.RAID.png)  
5. Далее начинаем настройку LVM и создаём группу томов.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/5.LVM.png)  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/6.LVM_step2.png)  
6. Для каждого тома сделали соответствующие им точки монтирования и завершили настройку LVM.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/7.Finish_LWM.PNG)  
7. После "разметки дисков" устанавливаем GRUB на 1 устройство sda и загружаем систему.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/9.Grub_disk1.PNG)
8. Выполнили копирование содержимого раздела /boot с диска sda(ssd1) на диск sdb(ssd2). Посмотрели информацию о дисках с помощью команд:  
- **fdisk -l** - смотрим имеющиеся диски и разделы;
- **lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT** - команда показывает: название дисков и разделов, тип файловой системы, размер всего диска и каждого раздела, а также точки монтирования.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/13.fdisk-l.png)  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/10.inf_fisk.png)  
9. Посмотрели информацию о текущем RAID с помощью команды:  
- **cat /proc/mdstat** - показывает информацию о текущем RAID;  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/11.inf_RAID.png)  
10. Посмотрели выводы с помощью команд:  
- **pvs** - отображение физических томов;
- **lvs** - вывод информации о logical volume;  
- **vgs** - отображение volume group, информация об этих группах;  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/12.inf_dop.PNG)  

# Задание 2  
1. В процессе работы у нас отказывает один ssd, и нам требуется восстановить все его данные. При проверке ВМ на работоспособность после отключения SSD мы можем увидеть, что, действительно, остался только один диск.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task2/1.ssd_upal.png)  
2. Проверим статус RAID-массива с помощью команды: *cat /proc/mdstat*  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task2/2.status_RAID.png)  
3. Создаем в ВМ новый диск и называем его ssd3. Убедимся, что диск был успешно добавлен командой *fdisk -l*.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task2/3.fdisk.png)  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task2/4.fdisk(2).png)  
4. Скопировали таблицу разделов со старого диска на новый с помощью команды sfdisk *-d /dev/sda | sfdisk /dev/sdb*. Затем добавляем raid в sdb2 c помощью команды *mdadm --manage /dev/md0 --add /dev/sdb2*. Посмотрим информацию о дисках после замены SSD на новый и добавления его в RAID.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task2/7.inf.png)  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task2/6.mdadm.png)  
5. Осталось скопировать /boot, установить grup и выполнить перезагрузку ВМ. В результате всех этих действий мы успешно восстановили диск.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task2/9.finish.png)  

# Задание 3
**В этом задании у нас падает еще один SSD, мы заменяем его на новый объемом 7 Гб и добавляем 2 новых HDD. Благодаря LVM и RAID мы смогли восстановить наши данные и включили новый SSD в наш volume group.**  
1. После удаления ssd2 посмотрим текущее состояние дисков и RAID:  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/1.delete_ssd2.png)  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/2.inf_RAID.png)  
2. Далее после добавления SSD4, копирования на него таблицы разделов и перемонтирования /boot, а также после установки grub, мы можем посмотреть новую информацию о дисках:  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/3.SSD4.png)  
3. Создаём новый raid массив с включением туда только одного ssd - *mdadm --create --verbose /dev/md63 --force --level=1 --raid-devices=1 /dev/sdb2*.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/4.RAID.png)  
4. Настроим LVM. Создадим новый физический том, включив в него ранее созданый RAID.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/5.LVM.png)  
5. Далее следует увеличить VG с помощью команды: *vgextend system /dev/md63*, а также переместить данные со старого диска на новый. После чего изменим VG, удалив оттуда RAID старого диска - *vgreduce system /dev/md0*.
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/6.vgs.png)
6. Удалим ssd3 диск и добавим ssd5, hdd1, hdd2. Затем снова скопируем таблицу разделов на новый ssd, скопируем /boot и установим grub. Изменяем размер второго раздела (ssd5) c помощью *fdisk /dev/xxx*.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/8.SSD5.png)
7. Добавим SSD 5 в RAID массив и увеличим размеры разедела на обоих дисках, а затем увеличим размеры самого массива:
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/10.RAID.png)
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/0.proba.png)
9. Увеличим размеры VG и самих root и var, и получим конечный результат работы с SSD:
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/12.VG.png)
10. Создадим на HHD логический том и отформатируем их под ext4:  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/13.HHD.png)
11. Перемонтировали варлоги:  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/14.varl.png)
12. Изменяем fstab:  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/15.fstab.png)
13. Снимем последние pvs, lvs и vgs показания:
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/16.pokas.png)
14. Последние показания о дисках и RAID:  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/17.finish.png)
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task3/18.finish.png)
