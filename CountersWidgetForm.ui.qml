import QtQuick
import QtQuick.Controls 6.3

Item {
    property alias tpmText: tpmText
    property alias turnsText: turnsText
    property alias hbpmText: hbpmText
    property alias startButton: startButton
    property alias timeText: timeText
    Rectangle {
        id: rectangle
        x: 8
        y: 8
        width: 624
        height: 294
        color: "#ffffff"

        Text {
            id: tpmText
            height: 54
            text: "0"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: 68
            anchors.rightMargin: 8
            anchors.leftMargin: 128
        }

        Text {
            id: tpmName
            height: 54
            text: "TPM"
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: 68
            anchors.leftMargin: 18
        }

        Text {
            id: turnsText
            height: 54
            text: "0"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: 8
            anchors.rightMargin: 8
            anchors.leftMargin: 454
        }

        Text {
            id: turnsName
            height: 54
            text: "Turns"
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 323
            anchors.topMargin: 8
        }

        Text {
            id: hbpmText
            height: 54
            text: "0"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: 128
            anchors.rightMargin: 8
            anchors.leftMargin: 128
        }

        Text {
            id: hbpmName
            height: 54
            text: "HBPM"
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 8
            anchors.topMargin: 128
        }

        Button {
            id: startButton
            x: 8
            y: 247
            width: 98
            height: 39
            text: qsTr("Start")
        }

        Text {
            id: timeName
            height: 54
            text: "Time"
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 9
            anchors.topMargin: 8
        }

        Text {
            id: timeText
            width: 152
            height: 54
            text: "0m 0s"
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 40
            horizontalAlignment: Text.AlignLeft
            anchors.topMargin: 8
            anchors.leftMargin: 147
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:7}D{i:9}D{i:10}
}
##^##*/

