function Item(_name, _sprite, _description, _weight, _cost = 100) constructor {
    name = _name;
    sprite = _sprite;
    description = _description;
    weight = _weight;
    cost = _cost;
    unlocked = false;
    equiped = false;
}

function PassiveItem(_name, _sprite, _description, _weight, _cost, _ability) : Item(_name,  _sprite, _description, _weight, _cost = 100) constructor {
    ability = _ability;
}

function ActiveItem(_name, _sprite, _description, _weight, _cost, _ability) : Item(_name,  _sprite, _description, _weight, _cost = 100) constructor {
    ability = _ability;
}