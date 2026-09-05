# OutputDebugOverload
A drop-in replacement for OutputDebug. 
- Overloads native OutputDebug function.
- Accepts all data types and any number of arguments unlike the vanilla function.

---

## What?

OutputDebug is super useful for quick debugging but is kind of annoying that it only accepts a `String` parameter.  
This helper file tackles that pain point. 

You can use the function how you usually do with a couple more additional features.

- **Safe-ish error handling** – runtime errors inside the logger are caught and reported as `[OutputDebug Error] ...`.
- **Windows-native** – uses `OutputDebugStringW` (via `RawOut`) so output appears in any debugger or tool that listens for `OutputDebug` (VS Code, DebugView, etc.).

You'll want this if you just want:

- A fast inspection of variables.
- A drop-in replacement for OutputDebug, seriously.
- Keeping debug output structured and as readable as possible.
- To just keep that damn MsgBox away.

---

## Installation

OutputDebugOverload is a single `.ahk` file with no external dependencies.

### Option 1: Manual copy (recommended)

1. Download [`OutputDebugOverload.ahk`](OutputDebugOverload.ahk) from this repository.
2. Place it in your project folder or a shared `lib` directory, for example:

   ```text
   your_ahk_project/
     lib/
       OutputDebugOverload.ahk
     main.ahk
   ```

3. Include it at the top of your main script:

   ```ahk
   #Requires AutoHotkey v2.0
   #Include "lib\OutputDebugOverload.ahk"
   ```

   Or, if it’s in the same folder:

   ```ahk
   #Include "OutputDebugOverload.ahk"
   ```

That’s it. Once included, the global `OutputDebug` function is overridden and ready to use.

### Option 2: Git submodule

If you manage AHK libraries with Git:

```bash
cd your_ahk_project
git submodule add https://github.com/stylebash/OutputDebugOverload.git lib/OutputDebugOverload
```

Then include:

```ahk
#Include "lib\OutputDebugOverload\OutputDebugOverload.ahk"
```

### Requirements

- AutoHotkey v2.0 or later
- Windows (uses `OutputDebugStringW` under the hood)
- A debugger or tool that captures `OutputDebug` output, such as:
  - Visual Studio Code with an AHK debugger
  - Sysinternals [DebugView](https://learn.microsoft.com/en-us/sysinternals/downloads/debugview)

---

## Usage

After including the file, call `OutputDebug` like how it is without this helper.  
But now, we're able to pass any number and type of values as well.

### Basic usage

```ahk
#Requires AutoHotkey v2.0
#Include "OutputDebugOverload.ahk"

name := "Mark"

; like the vanilla version:
OutputDebug name
; or
OutputDebug(name)
```
But now, we can also pass none-String data types:
```ahk
counter := 32
levitate := 32.543
old := false

OutputDebug counter
OutputDebug levitate
OutputDebug old
```
like objects, too:
```ahk
scene := Object()
scene.charactr := "Johnny"
scene.script := "...Oh hi, " . name ."!"
scene.location := "rooftop"

preScript := ["i", "did", "not", "hit", "her,", "i", "did", "NOT!"]

OutputDebug scene
OutputDebug preScript
```
We can bunch 'em up like so:
```ahk
OutputDebug counter, levitate, old
OutputDebug scene, preScript
```
This groups up the output per function call in the console like so:
```text
[Integer]: 32
[Float]: 32.542999999999999
[Integer]: 0

[Object]: {charactr: "Johnny", location: "rooftop", script: "...Oh hi, Mark!"}
[Array]: ["i", "did", "not", "hit", "her,", "i", "did", "NOT!"]
```
Maybe you're using OutputDebug in a lot of places and you want to put a special tracker on some of the variables.  
This is where custom labeling comes in.
All you have to do is add a string as a last argument prefixed with a ":" like so:
```ahk
OutputDebug scene, preScript, ':pimped debug text'
```
Any text after `:` will be used as the custom label. And it'll look like this:
```text
[pimped debug text] (Object): {charactr: "Johnny", location: "rooftop", script: "...Oh hi, Mark!"}
[pimped debug text] (Array): ["i", "did", "not", "hit", "her,", "i", "did", "NOT!"]
```
notes** 
- Each argument appears on its own line; separate calls are separated by a blank line in the debug stream.
- Deep structures are stringified up to a maximum depth (`MAX_STRINGIFY_DEPTH`, default 10) to avoid runaway output.
- More usage examples (with inline documentation) can be found at [outputDebugOverload-usage-demo.ahk](https://github.com/stylebash/OutputDebugOverload/blob/main/outputDebugOverload-usage-demo.ahk)

### Format modes
Control how values are printed using the last argument:

- **typed (default)**
  ```ahk
  OutputDebug levitate, 'typed'
  ```
  Output:
  ```text
  [Float]: 32.542999999999999
  ```

- **Bare (raw data only)**
  ```ahk
  OutputDebug levitate, "bare"
  ```
  Output:
  ```text
  32.542999999999999
  ```

If you omit the format argument, '`typed`' is used by default.

---

## Customization
If you want to customize the output format for any reason.

Add a 3rd, 4th, or more values on this variable:
```ahk
FORMAT_TYPES := [
    "bare", ; yes, you can type all of it in one hand. You're welcome.
    "typed",
    "super-omega-non-standard-alpha-sigma-chad-bbq-format"
]
```

Add your format in the switch case under the `FormatValue` function.  
For example, if you added a 3rd value on the FORMAT_TYPES variable:
```ahk
    .
    .
    .
    switch formatType {
      ...
      case FORMAT_TYPES[3]:
        strVal := "<" . Type(val) . ">- " . strVal
      ...
    }
```

---

### Viewing output

To see the debug output:

- Run your script with a debugger attached in **VS Code** and check the **Debug Console**.
- Use **DebugView** (Sysinternals) to capture `OutputDebug` messages system-wide.
- Any tool that listens for `OutputDebug` events will receive the formatted lines.
- I use VSCode with AHK++, so this it looks like this:
<img width="1496" height="368" alt="image" src="https://github.com/user-attachments/assets/742289ff-4eb8-4d01-9fd7-51bb4515a312" />
^ Did you see that Runtime error too?! It's not in a MsgBox! Yeeeeeeeeeeeeeeeeeeeeeeeah boi!

---

*OutputDebugOverload is provided as-is under the MIT License.
