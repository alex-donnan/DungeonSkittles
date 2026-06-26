function Item(_name, _sprite, _description, _weight, _cost) constructor {
    name = _name;
    sprite = _sprite;
    description = _description;
    weight = _weight;
    cost = _cost;
    unlocked = false;
}

function PassiveItem(_name, _sprite, _description, _weight, _cost, _ability) : Item(_name,  _sprite, _description, _weight, _cost) constructor {
    ability = _ability;
    timer = 0;
}

function ActiveItem(_name, _sprite, _description, _weight, _cost, _ability) : Item(_name,  _sprite, _description, _weight, _cost) constructor {
    ability = _ability;
}