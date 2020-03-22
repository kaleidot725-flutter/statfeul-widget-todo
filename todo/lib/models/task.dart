
class Task {
   String _id;
   bool _checked;
   String _name;

   String get id => _id;
   bool get checked => _checked;
   String get name => _name;

   Task(this._id, this._checked, this._name);
}