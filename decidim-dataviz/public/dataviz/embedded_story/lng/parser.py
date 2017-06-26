import ezodf
import json

guio = 'guio.ods'

spreadsheet = ezodf.opendoc(guio)
sheet=spreadsheet.sheets['Textos']

rows=[]
for r in range(1,sheet.nrows()):
    if sheet[r,0].value != None:
        rows.append(r)

lang=[(1, 'ca'),(2, 'es'),(3, 'en')]

for l in lang:
    g={}
    for r in rows:
        print r, sheet[r,l[0]].value.encode('utf-8').replace('\n', '<br>').replace('<br>', '').replace("'", '&#39')
        g['r_'+str(sheet[r,0].value)]=sheet[r,l[0]].value.encode('utf-8').replace('\n', '<br>').replace('<br>', '').replace("'", '&#39')

    result = json.dumps(g, ensure_ascii=False)
    f=open(str(l[1])+'/translation.json', 'w+')
    f.write(result)
    f.close()
