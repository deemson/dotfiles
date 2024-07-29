import path from 'node:path'
import fs from 'node:fs/promises'

const jsonPath = path.resolve(path.join(
  import.meta.dirname,
  '..',
  '..',
  'colors',
  'morhetz-gruvbox',
  'gruvbox2.json'
))
const jsonBuf = await fs.readFile(jsonPath)
const jsonString = jsonBuf.toString()
const jsonObj = JSON.parse(jsonString)

const cellWidth = 10

const pad = (str) => {
  const padding = cellWidth - str.length
  const leftPad = Math.floor(padding / 2)
  const rightPad = padding - leftPad
  return ' '.repeat(leftPad) + str + ' '.repeat(rightPad)
}

const display = (arr) => {
  const linesToDisplay = []
  for (const line of arr) {
    linesToDisplay.push(line.map(c => pad(c[0])).join(''))
    linesToDisplay.push(line.map(c => pad(c[1])).join(''))
    linesToDisplay.push('')
  }
  console.log(linesToDisplay.join('\n'))
}

display(jsonObj.dark)
console.log()
console.log()
console.log()
display(jsonObj.light)