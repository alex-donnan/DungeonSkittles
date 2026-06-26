function Item(_name, _sprite, _description, _weight, _cost) constructor {
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

function PassiveItem(_name, _sprite, _description, _weight, _cost, _ability) : Item(_name,  _sprite, _description, _weight, _cost) constructor {
    ability = _ability;
}

function ActiveItem(_name, _sprite, _description, _weight, _cost, _ability) : Item(_name,  _sprite, _description, _weight, _cost) constructor {
    ability = _ability;
}