#Requires AutoHotkey v2.0
#SingleInstance Force
#Include outputDebugOverload.ahk

; #region: DeclareVariables
; Integer
count := 42
; Float
price := 19.99
; String (The only argument type the OG OutputDebug function accepts)
name := "Mark"
; Array
colors := ["red", "green", "blue"]
newColors := [
    "yellow", 
    "purple", 
    "white"
]
; Map (Associative array; key-value pair declaration in AHK is weird)
user := Map("name", "Mark", "age", 41, "active", false)

; Object (generic object with properties)
person := Object()
person.name := "Mark"
person.age := 41

; Func (function reference/expression)
add := (a, b) => a + b

; Built-in object types
clipboardText := A_Clipboard      ; String (clipboard content)
scriptPath := A_ScriptFullPath    ; String
tickCount := A_TickCount          ; Integer

; Boolean (actually integers in AHK)
isActive := true    ; 1
; Null (no value. But not really a thing in AHK.)
notnothing := null
; #endRegion DeclareVariables

reformatext := 'empty'
; #region: usageDemo

; Undefined/undeclared variable assigned to the variable
; On enabling the ff line, we won't see the Debug Console messages by succeeding OuputDebug calls below. 
; But the error message is now on the Debug Console, not on the Message Box.
; OutputDebug thisVariableDoesNotExist 

OutputDebug count
OutputDebug price, 'typed' ; 'typed' is the default format option. It's the same as not explicitly passing it.
OutputDebug name, 'bare' ; 'bare' is the 2nd format option. This needs to be explicitly passed.

; A demo of how multiple arguments passed to OutputDebug are grouped in the Debug Console.
; And that we can pass any number of arguments.
OutputDebug newColors, 'plain text/string', '3rd parameter', 2, ["in", "line", "array"], notnothing

OutputDebug 'Var name: user', user  ; Useful for when we want to track the name of the variable we're passing to OutputDebug.
; Custom labeling. Another way to track the variable. With a few restrictions.
; restriction 1: Has to be the last parameter we pass to OutputDebug.
; restriction 2: String has to start (prefix) with the ':' character.
OutputDebug person, ':can be any text. For example: <([person])>'

OutputDebug add ; Catch expressions/anonymous functions.

OutputDebug clipboardText, scriptPath, tickCount, ':built-in object types'

OutputDebug isActive

OutputDebug notnothing ; Catch null declarations, just in case.

; Maybe you're going insane from programming and just want to see what's inside the Debug Console without passing any arguments for no reason at all... At all. At all. At all. At all. At all....
OutputDebug

; Undefined/undeclared variable assigned to the variable
; We can still see the Debug Console messages by OutputDebug above.
OutputDebug thisVariableDoesNotExist
; #endRegion usageDemo