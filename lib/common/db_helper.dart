import 'package:intl/intl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:task_windows/common/TaskModel.dart';
import 'package:task_windows/common/eventbus.dart';
class DBHelper{


  //定义了一个静态变量---_dbHelper，保存DBHelper类的单例实例
  static DBHelper? _dbHelper;

  //定义了一个静态方法---getInstance()获取DBHelper的单例实例
  //如果_dbHelper为空，就创建一个新的DBHelper实例
  static DBHelper getInstance(){
    if(_dbHelper==null)
    {
      _dbHelper=DBHelper();
    }
    return _dbHelper!;
  }

  //_db是一个Database类型的成员，用于存储数据库实例
  Database? _db;
  //数据库中的表
  static final String _ALLTask="_ALLTask";//所有任务

  //database是一个异步getter函数，用于返回数据库实例。如果_db为空，就调用initDB方法初始化数据库。
  Future<Database> get database async{
    if(_db!=null){
      return _db!;
    }
    _db=await initDB();
    return _db!;
  }

  //初始化数据库
  initDB()async{
    //1、初始化数据库
    sqfliteFfiInit();
    //2、获取databaseFactoryFfi对象
    var databaseFactory = databaseFactoryFfi;
    print("数据库的地址:${await databaseFactory.getDatabasesPath()}");
    //3、创建数据库
    return await databaseFactory.openDatabase(
        //数据库路径
        path.join(await databaseFactory.getDatabasesPath(), "TO-DO.db"),
        //打开数据库操作
        options: OpenDatabaseOptions(
          //版本
          version: 5,
          //创建时操作
          onCreate: (db,version)async{
            print("创建数据库");
            return await db.execute(
              "CREATE TABLE $_ALLTask ("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "content TEXT,"
                  "ownType STRING,"
                  "startDate STRING,"
                  "endDate STRING,"
                  "createTime STRING,"
                  "completeTime STRING,"
                  "repeat STRING,"
                  "isCompleted INTEGER,"
                  "priority INTEGER"
                  ")"
            );
          }
        )
      );
  }


  //插入数据——法一 insert
  Future<int>insert(Task task)async{
    Database db=await database;
    print("insert function called");
    print("插入的数据:${task.toJson()}");
    /*insert方法会返回最后的行id*/
    int id=await db.insert(_ALLTask, task.toJson());
    eventBus.fire(EventSuccessAddTask(true));
    return id;
  }

  //插入数据——法二 rawInsert
  Future<int> rawInsert(Task task) async{
    Database db=await database;
    print("insert function called");
    print("插入的数据:${task.toJson()}");
    return await db.rawInsert(
        "INSERT INTO $_ALLTask (content, ownType, startDate, endDate, createTime, completeTime, repeat, isCompleted)"
        " VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      [task.content,task.ownType,task.startDate,task.endDate,task.createTime,task.completeTime,task.repeat,task.isCompleted]
    );
  }

  //查询数据
  /*完成情况的升序：0 未完成 1 完成，已完成的在最下面
   *优先级的降序，优先级大的在上面，小的在下面
   *创造时间的升序，创造时间早的在上面，晚的在下面*/
  /*查询到后返回的是一个List<Map<String,Object?>>类型的列表，每一个元素都是Map<String,Object?>
   *result就是List<Map<String,Object?>>类型的列表
   *result.map((taskMap) => Task.fromJson(taskMap))=======>遍历每一个元素，将每一个元素都执行给定的函数,此处是Task.fromJson(taskMap)，然后返回一个新的迭代器
   *所以这个迭代器里的每一个元素都转换成了Task类型
   *.toList();将这个迭代器转换成列表
   * 所以最后就返回了一个Task类型的列表  */
  //升序排列
  Future<List<Task>> queryASC() async{
    Database db=await database;
    print("query function called!");
    // await db.execute("VACUUM");
    // var result=await db.rawQuery("SELECT * FROM $_ALLTask ORDER BY datetime(createTime) DESC");
    /*先按照isCompleted完成状态升序排列，isCompleted=0，未完成 isCompleted=1，完成
     *再按照createTime创造时间升序排列（最新创建的任务在最下面） */
    var result=await db.query(_ALLTask,orderBy: "isCompleted ASC,priority DESC, datetime(createTime) ASC");
    /*result.forEach((element) {
      print("创建:${element}");
    });*/
    // print("result:${result}");
    return result.map((taskMap) => Task.fromJson(taskMap)).toList();/*此时返回的是一个List<Task>类型*/
  }

  //降序排列
  Future<List<Task>> queryDESC() async{
    Database db=await database;
    print("query function called!");
    // await db.execute("VACUUM");
    // var result=await db.rawQuery("SELECT * FROM $_ALLTask ORDER BY datetime(createTime) DESC");
    /*先按照isCompleted完成状态升序排列，isCompleted=0，未完成 isCompleted=1，完成
     *再按照createTime创造时间升序排列（最新创建的任务在最下面） */
    var result=await db.query(_ALLTask,orderBy: "isCompleted ASC,priority DESC,datetime(createTime) DESC");
    /*result.forEach((element) {
      print("创建:${element}");
    });*/
    // print("result:${result}");
    return result.map((taskMap) => Task.fromJson(taskMap)).toList();/*此时返回的是一个List<Task>类型*/
  }

  //添加列
  Future<void> addColumn() async {
    Database db = await database;
    //向$_ALLTask数据表添加int型的列priority，如果不设置默认值，则新列中的所有值都将为NULL。
    await db.execute("ALTER TABLE $_ALLTask ADD COLUMN priority INT");
    await db.execute("UPDATE $_ALLTask  SET priority = ? WHERE priority IS ?",[0,null]);
  }

  //设置新列的默认值
  Future setdefaultValue()async{
    Database db = await database;
    await db.execute("UPDATE $_ALLTask  SET priority = ? WHERE priority IS ?",[0,null]);
  }


  /*使用 whereArgs 将参数传递给 where 语句。有助于防止 SQL 注入攻击*/
  //删除数据
  Future delete(Task task)async{
    Database db=await database;
    print("delete function called!");
    eventBus.fire(EventSuccessAddTask(true));
    await db.delete(
        _ALLTask,
        where: "id=?",
        whereArgs: [task.id]);
    eventBus.fire(EventSuccessAddTask(true));
  }

  //更新任务完成情况——————修改完成时间、完成状态
  Future updateComplete(int newValue,Task task)async{
    Database db=await database;
    //修改为完成
    if(newValue==1) {
      await db.rawUpdate(
          '''
          UPDATE $_ALLTask
          SET isCompleted=?,completeTime=?
           WHERE id=?
            ''',
          [newValue,"${DateFormat('yyyy-MM-dd').format(DateTime.now())+"--"+DateFormat.Hms().format(DateTime.now()).toString()}",task.id]);
    }
    //修改为未完成
    else if(newValue==0){
      await db.rawUpdate(
          '''
          UPDATE $_ALLTask
          SET isCompleted=?,completeTime=?
           WHERE id=?
            ''',
          [newValue,null, task.id]);
    }
    print("任务完成状态修改");
    eventBus.fire(EventSuccessAddTask(true));
  }

  //修改任务内容(全部数据)
  /*修改任务后会发起一个*/
  Future updateInfo(Task task)async{
    print("要修改的任务:${task.toJson()}");
    Database db=await database;
    db.update(_ALLTask, task.toJson(), where: 'id=?', whereArgs: [task.id]);
    eventBus.fire(EventSuccessAddTask(true));
  }

  //修改所有的创造时间为ISO 8601格式，这可以用于SQLite的日期时间函数
  Future updateDate(Task task,newDate) async{
    print("修改日期格式");
    Database db=await database;
    return db.rawUpdate(
      '''
      UPDATE $_ALLTask
      SET createTime=?
      WHERE id=?
      ''',
      // ["${DateFormat('yyyy-MM-dd').format(DateTime.now())+"--"+DateFormat.Hms().format(DateTime.now()).toString()}",task.id]
      [newDate,task.id]
    );
  }

  Future updatePriority(Task task) async{

    Database db=await database;
    //未修改的优先级=0，则修改为1
    if(task.priority==0){
      db.rawUpdate(
        '''UPDATE $_ALLTask SET priority = ? WHERE id=?''',
        [1,task.id]
      );
    }

    else if(task.priority==1){
      db.rawUpdate(
          '''UPDATE $_ALLTask SET priority = ? WHERE id=?''',
          [0,task.id]
      );
    }
    eventBus.fire(EventSuccessAddTask(true));
  }
}