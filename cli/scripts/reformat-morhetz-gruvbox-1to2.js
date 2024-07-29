import path from 'node:path'
import fs from 'node:fs/promises'

const jsonPath = path.resolve(path.join(
  import.meta.dirname,
  '..',
  '..',
  'colors',
  'morhetz-gruvbox',
  'gruvbox1.json'
))
const jsonBuf = await fs.readFile(jsonPath)
const jsonString = jsonBuf.toString()
const jsonObj = JSON.parse(jsonString)

const reformat = (obj) => {
  const arr = []
  for (const name in obj) {
    let correctedName = name
    if (!name.startsWith('bg') && !name.startsWith('fg')) {
      correctedName = name.replace('2', '')
    }
    arr.push([correctedName, obj[name]])
  }
  arr.splice(22, 0, ['gray', obj.gray2])
  arr.splice(24, 0, ['', ''])
  const subArrs = []
  for (let i = 0; i < arr.length; i += 8) {
    subArrs.push(arr.slice(i, i + 8))
  }
  return subArrs
}

const lines = [
  '{',
  '  "dark": ['
]

for (const [index, arr] of reformat(jsonObj.dark).entries()) {
  let line = '    ' + JSON.stringify(arr)
  if (index !== 3) {
    line += ','
  }
  lines.push(line)
}

lines.push('  ],', '  "light": [')

for (const [index, arr] of reformat(jsonObj.light).entries()) {
  let line = '    ' + JSON.stringify(arr)
  if (index !== 3) {
    line += ','
  }
  lines.push(line)
}

lines.push('  ]', '}')

await fs.writeFile(path.resolve(path.join(
  import.meta.dirname,
  '..',
  '..',
  'colors',
  'morhetz-gruvbox',
  'gruvbox2.json'
)), lines.join('\n'))