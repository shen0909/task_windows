想用flutter做一个固定在桌面上的轻量级任务管理软件

1、任务基本操作

√ 1.1 添加任务

    任务类型 0-工作 1-学习 2-生活
    任务id
    任务内容
    任务开始日期
    任务结束日期
    任务是否重复
    任务创建时间
    任务完成日期、时间
    任务完成状态 
    任务优先级
    await db.insert(_ALLTask, task.toJson());

√ 1.2 查询任务:转换成List<Task>类型返回

    /*查询到后返回的是一个List<Map<String,Object?>>类型的列表，每一个元素都是Map<String,Object?>
    *result就是List<Map<String,Object?>>类型的列表
    *result.map((taskMap) => Task.fromJson(taskMap))=======>遍历每一个元素，将每一个元素都执行给定的函数,此处是Task.fromJson(taskMap)，然后返回一个新的迭代器
    *所以这个迭代器里的每一个元素都转换成了Task类型
    *.toList();将这个迭代器转换成列表
    * 所以最后就返回了一个Task类型的列表  */
    var result=await db.query(_ALLTask);
    return result.map((taskMap) => Task.fromJson(taskMap)).toList();/*此时返回的是一个List<Task>类型*/

√ 1.3 编辑任务:更新整个任务

    await db.update(_ALLTask, task.toJson(), where: 'id=?', whereArgs: [task.id])

√ 1.4 删除任务

    await db.delete(_ALLTask,where: "id=?",whereArgs: [task.id]);

√ 1.5 完成任务:更新完成状态和完成时间

    await db.rawUpdate(
    '''UPDATE $_ALLTask SET isCompleted=?,completeTime=? WHERE id=?''',
    [newValue,"${DateFormat('yyyy-MM-dd').format(DateTime.now())+"--"+DateFormat.Hms().format(DateTime.now()).toString()}",task.id]);

2、任务窗口

√ 2.1 置顶于所有窗口之上
√ 2.2 自定义窗口
2.3 拖动窗口
2.4 窗口置顶自定义

3、任务排序

4、任务置顶

3、点击日期显示当天任务

4、导航栏显示今天的日期和左侧有任务图标，点击弹出侧边栏

5、侧边栏:已完成任务、今日全部任务、历史任务

当:当前选中的日期属于开始和结束日期之间时，显示任务

当前选中日期和开始、结束日期都是String类型

第一步、转换成日期格式

    late var selectedDate=DateFormat('yyyy-MM-dd').format(DateTime.now());--->selectedDate已经是日期字符串

    DateTime current=DateTime.parse(Get.find<TaskPageLogic>().state.selectedDate);---->将日期字符串解析为 DateTime 对象。
    
    String? startDate;/*开始时间*/
    String? endDate;/*结束时间*/
    
    DateTime startDate = DateFormat('yyyy-MM-dd').parse(taskInfo[index].startDate!);
    DateTime endDate = DateFormat('yyyy-MM-dd').parse(taskInfo[index].endDate!);

    DateFormat('yyyy-MM-dd') 创建了一个 DateFormat 实例，该实例指定了日期字符串的格式为 yyyy-MM-dd，即年份-月份-日期的格式。
    然后，.parse(taskInfo[index].startDate!) 调用 DateFormat 类的 parse() 方法，将日期字符串解析为 DateTime 对象。

第二步、比较日期
    在开始日期之后,在结束日期之前： startDate.isBefore(current)&&endDate.isAfter(current)
    在开始日和结束日当天：startDate.isAtSameMomentAs(current)|| endDate.isAtSameMomentAs(current)
