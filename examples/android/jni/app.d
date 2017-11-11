module app;

import dlangui;

mixin APP_ENTRY_POINT;

/// entry point for dlangui based application
extern (C) int UIAppMain(string[] args) {

    // load theme from file "theme_default.xml"
    //Platform.instance.uiTheme = "theme_default";

    // create window
    Log.d("Creating window");
    Window window = Platform.instance.createWindow("DlangUI example - HelloWorld", null, WindowFlag.Modal);
    Log.d("Window created");

    // create some widget to show in window
    //window.mainWidget = (new Button()).text("Hello, world!"d).margins(Rect(20,20,20,20));
    window.mainWidget = parseML(q{
        VerticalLayout {
            margins: 10pt
            padding: 10pt
            layoutWidth: wrap
            // red bold text with size = 150% of base style size and font face Arial
            TextWidget { text: "Hello wWorld example for DlangUI"; textColor: "red"; fontSize: 12pt; fontWeight: normal; fontFace: "Arial"; layoutWidth: wrap }
            // arrange controls as form - table with two columns
            TableLayout {
                colCount: 2
                layoutWidth: wrap
                TextWidget { text: "param 1" }
                EditLine { id: edit1; text: "some text"; layoutWidth: wrap }
                TextWidget { text: "param 2" }
                EditLine { id: edit2; text: "some text for param2"; layoutWidth: wrap }
                TextWidget { text: "some radio buttons" }
                // arrange some radio buttons vertically
                VerticalLayout {
                    layoutWidth: wrap
                    RadioButton { id: rb1; text: "Item 1" }
                    RadioButton { id: rb2; text: "Item 2" }
                    RadioButton { id: rb3; text: "Item 3" }
                }
                TextWidget { text: "and checkboxes" }
                // arrange some checkboxes horizontally
                HorizontalLayout {
                    layoutWidth: wrap
                    CheckBox { id: cb1; text: "checkbox 1"; minWidth: 10pt; }
                    CheckBox { id: cb2; text: "checkbox 2"; minWidth: 10pt; }
                    ComboEdit { id: ce1; text: "some text"; minWidth: 20pt; items: ["Item 1", "Item 2", "Additional item"] }
                }
            }
            EditBox { layoutWidth: 20pt; layoutHeight: 10pt }
            HorizontalLayout {
                Button { id: btnOk; text: "Ok" }
                Button { id: btnCancel; text: "Cancel" }
            }
        }
    });
    // you can access loaded items by id - e.g. to assign signal listeners
    auto edit1 = window.mainWidget.childById!EditLine("edit1");
    auto edit2 = window.mainWidget.childById!EditLine("edit2");
    // close window on Cancel button click
    window.mainWidget.childById!Button("btnCancel").click = delegate(Widget w) {
        window.close();
        return true;
    };
    // show message box with content of editors
    window.mainWidget.childById!Button("btnOk").click = delegate(Widget w) {
        window.showMessageBox(UIString.fromRaw("Ok button pressed"d), 
                              UIString.fromRaw("Editors content\nEdit1: "d ~ edit1.text ~ "\nEdit2: "d ~ edit2.text));
        return true;
    };

    // show window
    window.show();

    // run message loop
    return Platform.instance.enterMessageLoop();
}

