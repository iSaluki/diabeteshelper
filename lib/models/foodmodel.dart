

class foodmodel {
  final String image;

  final String source;
  final String label;
  final double nutrient;


  foodmodel({this.image,   this.label, this.source,this.nutrient});

  factory foodmodel.fromMap(Map<String, dynamic> parsedJson) {
    return foodmodel(
        image: parsedJson["image"],

        source: parsedJson["category"],
        label: parsedJson["label"],
        nutrient: parsedJson["nutrients"]["CHOCDF"]
    );



  }
}

class nutrients {
  final String CHOCDF ;

  nutrients( {this.CHOCDF});
  factory nutrients.fromMap(Map<String, dynamic> parsedJson){
        return nutrients(
          CHOCDF: parsedJson["CHOCDF"],
        );
  }
}
