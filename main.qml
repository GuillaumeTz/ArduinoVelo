import QtQuick

import com.ArduiVelo.appArduiVelo

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Component.onCompleted:
    {
        ArduinoVelo.tryConnect();
    }

    CountersWidget
    {

    }
}
