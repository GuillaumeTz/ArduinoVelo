import QtQuick
import QtQuick.Controls
import QtCharts

Item {
    property alias tpmText: tpmText
    property alias turnsText: turnsText
    property alias hbpmText: hbpmText
    property alias startButton: startButton
    property alias timeText: timeText
    property alias splineTPM: splineTPM
    property alias splineTPMSeries: splineTPMSeries
    property alias valueAxisTPM_X: valueAxisTPM_X
    property alias valueAxisTPM_Y: valueAxisTPM_Y

    Rectangle {
        id: rectangle
        x: 8
        y: 8
        width: 624
        height: 364
        color: "#ffffff"

        ChartView {
            id: splineTPM
            anchors.fill: parent
            anchors.rightMargin: 8
            anchors.leftMargin: 8
            anchors.bottomMargin: 32
            anchors.topMargin: 32
            legend.visible: false

            ValueAxis {
                id: valueAxisTPM_Y
                min: 0
                max: 60
                tickCount: 1
                labelFormat: "%d"
            }

            ValueAxis {
                id: valueAxisHBPM_Y
                min: 0
                max: 60
                tickCount: 1
                labelFormat: "%d"
            }

            ValueAxis {
                id: valueAxisTPM_X
                min: 0
                max: 60
                tickCount: 6
                labelFormat: "%d"
            }

            SplineSeries {
                name: "TPM"
                pointLabelsClipping: true
                axisX: valueAxisTPM_X
                axisY: valueAxisTPM_Y

                pointsVisible: true
                useOpenGL: false
                id: splineTPMSeries
            }

            SplineSeries {
                name: "HBPM"
                pointLabelsClipping: true
                axisX: valueAxisTPM_X
                axisYRight: valueAxisHBPM_Y

                pointsVisible: true
                useOpenGL: false
                id: splineHBPMSeries
            }
        }

        Button {
            id: startButton
            y: 243
            width: 98
            height: 39
            text: qsTr("Start")
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 8
        }

        Item {
            id: groupItem
            opacity: 0.5
            anchors.fill: parent
            anchors.rightMargin: 4
            anchors.leftMargin: 4
            anchors.bottomMargin: 4
            anchors.topMargin: 4

            Text {
                id: tpmText
                y: 224
                width: 71
                height: 54
                text: "0"
                anchors.left: tpmName.right
                anchors.bottom: parent.bottom
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 6
                anchors.bottomMargin: 8
            }

            Text {
                id: tpmName
                y: 224
                height: 54
                text: "TPM"
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 5
                anchors.bottomMargin: 8
            }

            Text {
                id: turnsText
                width: 90
                height: 54
                text: "0"
                anchors.left: turnsName.right
                anchors.top: parent.top
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 11
                anchors.topMargin: 8
            }

            Text {
                id: turnsName
                x: 409
                height: 54
                text: "Turns"
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                anchors.rightMargin: 109
                anchors.topMargin: 8
            }

            Text {
                id: hbpmText
                y: 224
                width: 90
                height: 54
                text: "0"
                anchors.left: hbpmName.right
                anchors.bottom: parent.bottom
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 6
                anchors.bottomMargin: 8
            }

            Text {
                id: hbpmName
                x: 403
                y: 224
                height: 54
                text: "HBPM"
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                anchors.rightMargin: 104
                anchors.bottomMargin: 8
            }

            Text {
                id: timeName
                height: 54
                text: "Time"
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 1
                anchors.topMargin: 8
            }

            Text {
                id: timeText
                width: 152
                height: 54
                text: "0m 0s"
                anchors.left: timeName.right
                anchors.top: parent.top
                font.pixelSize: 40
                horizontalAlignment: Text.AlignLeft
                anchors.leftMargin: 47
                anchors.topMargin: 8
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2}D{i:7}
}
##^##*/

