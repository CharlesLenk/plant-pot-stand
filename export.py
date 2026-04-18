from scad_export import Folder, Model, export

files=Folder(
    name='scad_export/plant_pot_stand',
    contents=[
        [Model(name='stand_top', pot_d=size, pot_h=0.9 * size) for size in [85, 125, 175]],
        [Model(name='stand_bottom', pot_d=size, pot_h=0.9 * size) for size in [85, 125, 175]]
    ]
)

export(files)
