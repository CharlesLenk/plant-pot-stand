from scad_export.export import export
from scad_export.exportable import Folder, Model


files=Folder(
    name='scad_export/plant_pot_stand',
    contents=[
        Model(name='stand_top', pot_d=110, pot_h=110),
        Model(name='stand_bottom', pot_d=110, pot_h=110)
    ]
)

export(files)
