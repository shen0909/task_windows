//任务模型
class Task{

  int? id;
  String? ownType;/*属于哪个类别*/
  String? content;
  String? startDate;/*开始时间*/
  String? endDate;/*结束时间*/
  String? completeTime;/*完成时间*/
  String? createTime;/*创建时间*/
  String? repeat;/*重复周期*/
  int? isCompleted;/*是否已完成*/
  int? priority;/*优先级*/

  Task({
    this.id,
    this.ownType,
    this.content,
    this.startDate,
    this.endDate,
    this.completeTime,
    this.createTime,
    this.repeat,
    this.isCompleted,
    this.priority,
  });

  //当我们将数据保存到数据库中时，必须得转换成json格式
  /*json格式-->
   *key键值
   *key:value
   *value是从本地获取的*/
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data['id']=this.id;
    data['content']=this.content;
    data['ownType']=this.ownType;
    data['startDate']=this.startDate;
    data['endDate']=this.endDate;
    data['completeTime']=this.completeTime;
    data['createTime']=this.createTime;
    data['repeat']=this.repeat;
    data['isCompleted']=this.isCompleted;
    data['priority']=this.priority;
    return data;
  }
  //从数据库中获取数据时从json数据转换成task对象
  Task.fromJson(Map<String,dynamic> json){
    id=json['id'];
    content=json['content'];
    isCompleted=json['isCompleted'];
    ownType=json['ownType'];
    completeTime=json['completeTime'];
    startDate=json['startDate'];
    endDate=json['endDate'];
    createTime=json['createTime'];
    repeat=json['repeat'];
    priority=json['priority'];
  }
}