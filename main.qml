import QtQuick

import com.ArduiVelo.appArduiVelo

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("ArduinoVelo")

    Component.onCompleted:
    {
        ArduinoVelo.tryConnect();
    }

    Timer
    {
        interval: 1000
        repeat: true
        running: true

        onTriggered:
        {
            if (ArduinoVelo.isConnected())
                return;

            ArduinoVelo.tryConnect();
        }
    }

    CountersWidget
    {

    }
}
