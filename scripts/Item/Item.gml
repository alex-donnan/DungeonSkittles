function Item(_id, _name, _sprite, _description, _weight, _cost) constructor {
    id = _id;
    name = _name;
    sprite = _sprite;
    description = _description;
    timer = 0;
    
    weight = _weight;
    cost = _cost;
    unlocked = false;
    discovered = true;
    discovered_condition = undefined;
}

function PassiveItem(_id, _name, _sprite, _description, _weight, _cost, _ability) :
    Item(_id, _name,  _sprite, _description, _weight, _cost) constructor {
    ability = method(self, _ability);
}

function ActiveItem(_id, _name, _sprite, _description, _weight, _cost, _ability) :
    Item(_id, _name,  _sprite, _description, _weight, _cost) constructor {
    ability = method(self, _ability);
}