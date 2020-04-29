# VHDLkode, synthesizering og programmering i `VS Code`

- [VHDLkode, synthesizering og programmering i `VS Code`](#vhdlkode-synthesizering-og-programmering-i-vs-code)
  - [Krav:](#krav)
  - [ÅBEN PROJEKTMAPPEN VIA `VS Code`](#Åben-projektmappen-via-vs-code)
  - [`tasks.json`](#tasksjson)
  - [Synthesizing via `make`](#synthesizing-via-make)
  - [JTAG Programmering.](#jtag-programmering)
  - [Top level entity](#top-level-entity)
  - [Tilføj filer til projektet](#tilføj-filer-til-projektet)
  - [VS Code terminal](#vs-code-terminal)
  - [Anbefalede extensions](#anbefalede-extensions)
  - [Eksempel](#eksempel)

## Krav:

- **[VS Code](https://code.visualstudio.com/)** er installeret.
- **Quartus II 13.0sp1** er installeret.
- `makefile` hentet.

## ÅBEN PROJEKTMAPPEN VIA `VS Code`

```
File
-- Open Folder
-- Vælg din <Projektmappen>
```

Eller tryk <kbd>CTRL</kbd>+<kbd>K</kbd> <kbd>CTRL</kbd>+<kbd>O</kbd> og naviger til din projektmappe.

## `tasks.json`

For at bruge makefilen, skal der laves en `tasks.json` fil.

Den oprettes let i VS Code via:

- Terminal
  - Configure Tasks
  - Vælg "Create tasks.json file from template"
  - Vælg "Others"

Nu skulle der gerne være lavet en `tasks.json` fil som indeholder følgende:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "echo",
      "type": "shell",
      "command": "echo Hello"
    }
  ]
}
```

Slet indholdet i den, og indsæt dette:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "compile",
      "type": "shell",
      "windows": {
        "command": "make" // Synthesize !
      },
      "group": {
        "kind": "build",
        "isDefault": true // Defaulted til CTRL + SHIFT + B (BUILD)
      },
      "presentation": {
        "reveal": "always",
        "panel": "dedicated"
      }
    },
    {
      "label": "Clean", // Slet auxiliary filer (/output, /db, etc.)
      "type": "shell",
      "windows": {
        "command": "make clean"
      },
      "problemMatcher": []
    },

    {
      "label": "Program", // Programmer via JTAG
      "type": "shell",
      "windows": {
        "command": "make program"
      },
      "presentation": {
        "reveal": "always",
        "panel": "dedicated"
      },
      "problemMatcher": []
    }
  ]
}
```

Denne fil ligger i strukturen:

```
-Project folder
--.VS Code
---tasks.json
```

.VS Code mappen **kan** og **skal** altid inkluderes i nye projekters rodmappe - tilgængæld behøver man kun oprette den én gang.

## Synthesizing via `make`

For at kunne synthesize direkte fra VS Code, kræves en makefil
Denne findes på blackboard under:

```
E2DSD
--Wiki og hints
--- "Hint til hvis du vil skrive i LaTeX"
---- Makefile
```

Efter filen er hentet ligges den i rodmappen af VHDL projetet, og åbnes via en IDE - her vil jeg selvfølgelig foreslå VS Code...
I filen findes `PROJECT=< PROJEKT NAVN >` og denne rettes til det korrekte projektnavn. Hvis projektet er oprette via Quartus, findes en fil at typen:`.qsf`

```makefile
# Makefile
#  Version: 0.1
#  2018-06-19: CEF

# NOTE: you need to modify these settings:
QBIN=c:/altera/13.0sp1/quartus/bin
#QBIN=/opt/altera/13.0sp1/quartus/bin
PROJECT=< PROJEKT NAVN >
```

Når filen er lagt er ændet kan man bruge: <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>B</kbd> for at synthesize sit projekt.

## JTAG Programmering.

Når projektet er synthesizet og du vil have det over på et DE-2 board gøres følgende:

- <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>P</kbd>
- "Run Task"
- "Program"

Herefter vil boardet blive programmeret.

## Top level entity

For at ændre top level entityen, direkte fra VS Code, kan man åbne `<projectName>.qsf` filen og finde linjen:

```
set_global_assignment -name TOP_LEVEL_ENTITY <entityName>
```

og indsæt entity navnet i `<entityname>`.

Her `test_bench`:

```
set_global_assignment -name TOP_LEVEL_ENTITY test_bench
```

## Tilføj filer til projektet

Når synthesizeren melder at den ikke kan finde filen, er det oftest fordi filen ikke er linket til projektet.
Nyoprettede filer tilføjes ved at `<projectName>.qsf` igen åbnes, og linjen tilføje:

```
set_global_assignment -name VHDL_FILE <entityName.vhd>
```

Indsæt filnavnet i `<entityName>`, og **husk** `.vhd`.

Her `foo` og `bar`:

```
set_global_assignment -name VHDL_FILE foo.vhd
set_global_assignment -name VHDL_FILE bar.vhd
```

## VS Code terminal

Alle `make` kommandoer kan kaldes via VS Code's indbyggede terminal.

For at få den frem vælges

```
Terminal
-New Terminal
```

eller der trykkes: <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>Æ</kbd>

Herfra kan flg. gøres:

```
make            -- Synthesizer projektet.
make clean      -- Rydder op i projektet og sletter auxilary filer.
make program    -- Programmere projektet til boardet.
```

## Anbefalede extensions

- [Modern VHDL](https://marketplace.visualstudio.com/items?itemName=rjyoung.VSCode-modern-vhdl-support)
  - Syntax highlighting og snippets
    - `std` + <kbd>TAB</kbd> giver `std_logic_vecter(7 downtown 0)`
    - `ieee`+ <kbd>TAB</kbd> giver:
    ```vhdl 
    library IEEE; 
    use IEEE.std_logic_1164.all; 
    use IEEE.numeric_std.all;
    ``` 
- [VHDL Formatter](https://marketplace.visualstudio.com/items?itemName=Vinrobot.vhdl-formatter)

  - Formattering af VHDL kode - <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>F</kbd>

    ```vhdl
    if <conditional> then
    elsif <conditional> then
    elsif <conditional> then
    else
    if <conditional> then
    elsif <conditional> then
    if <conditional> then
    if <conditional> then
    end if;
    end if;
    end if;
    end if;
    ```

  - Efter formattering med VHDL formatter:
    ```vhdl
    IF < conditional > THEN
    ELSIF < conditional > THEN
    ELSIF < conditional > THEN
    ELSE
        IF < conditional > THEN
        ELSIF < conditional > THEN
            IF < conditional > THEN
                IF < conditional > THEN
                END IF;
            END IF;
        END IF;
    END IF;
    ```

- [VHDL LS](https://marketplace.visualstudio.com/items?itemName=hbohlin.vhdl-ls)
  - Error squiggles og syntax håndtering.

## Eksempel

Der ligger i [vhdleksempel](https://github.com/AdamHoej-au/VHDL-VSCode/tree/master/vhdl%20eksempel) mappen, et fuldt eksempel der kan køre i VS Code.
