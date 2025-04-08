import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Login"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 15

        TextField {
            id: usernameField
            placeholderText: "Username"
            Layout.fillWidth: true
        }

        TextField {
            id: passwordField
            placeholderText: "Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
        }

        RowLayout {
            spacing: 10
            Layout.alignment: Qt.AlignRight

            Button {
                text: "Log In"
                onClicked: console.log("Login attempted")
            }

            Button {
                text: "Clear"
                onClicked: {
                    usernameField.text = ""
                    passwordField.text = ""
                }
            }
        }
    }
}
