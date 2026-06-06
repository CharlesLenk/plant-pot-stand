from scad_export import Folder, Model, export

sizes = [85, 125, 175]

files=Folder(
    name='scad_export/plant_pot_stand',
    contents=[
        [Model(name='stand_top', pot_d=size, pot_h=0.9 * size) for size in sizes],
        [Model(name='stand_bottom', pot_d=size, pot_h=0.9 * size) for size in sizes]
    ]
)

export(files)
