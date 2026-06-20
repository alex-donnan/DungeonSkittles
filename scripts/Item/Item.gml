function Item(_name, _description, _weight) constructor {
    id = Inventory.item_id++;
    name = _name;
    description = _description;
    weight = _weight;
    level = 1;
}

function PassiveItem(_name, _description, _weight, _ability) : Item(_name, _description, _weight) constructor {
    ability = _ability;
}

function ActiveItem(_name, _description, _weight, _ability) : Item(_name, _description, _weight) constructor {
    ability = _ability;
}