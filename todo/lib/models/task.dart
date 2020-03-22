
class Task {
   String id;
   bool checked;
   String name;

   Task(this.id, this.checked, this.name);

   Map<String, dynamic> toMap() {
      return {
         'id': id,
         'name': name,
         'checked': checked ? 1 : 0,
      };
   }
}