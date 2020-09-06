class logmodel{
  int id;
  String dtetime;
  String bglocouse;
  String carbs;
  String activity;
  String insulin;
  String notes;

  logmodel ({this.id, this.activity, this.insulin,this.dtetime,this.carbs,this.bglocouse,this.notes});


  Map<String, dynamic> toMap() => {
    "id": id,
    "activity": activity,
    "insulin": insulin,
    "carbs": carbs,
    "bg":bglocouse,
    "datetime": dtetime,
    "notes":notes
  };


  factory logmodel.fromMap(Map<String, dynamic> json) => new logmodel(
    id: json["id"],
    activity: json["activity"],
    insulin: json["insulin"],
    carbs: json["carbs"],
    bglocouse: json["bg"],
    dtetime: json["datetime"],
    notes: json["notes"],
  );
}