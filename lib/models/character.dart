class Character {
   int id;
   String name;
   String img;
   String status;
   String gender;
   String species;

   Character({
      required this.id,
      required this.name,
      required this.img,
      required this.status,
      required this.gender,
      required this.species,
   });

   factory Character.fromJson(Map<String, dynamic> json) => Character(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      gender:  json["gender"],
      img: json["image"],
   );
   Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "status": status,
      "species": species,
      "gender": gender,
      "image": img,
   };
}


