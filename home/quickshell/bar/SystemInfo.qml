pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

property var memoryUsagePercentage: "0 %" 
property var memoryUsageDetail: "0 / 0 GiB" 




    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const result = text.trim().split(/\s+/);
                const total = parseFloat(result[1]) / (1024 * 1024);
                const used = parseFloat(result[2]) / (1024 * 1024);
				
				root.memoryUsagePercentage = Math.ceil((used /total) * 100).toString() + "%";
				root.memoryUsageDetail = `${used.toFixed(2)} / ${total.toFixed(2)} GiB`
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: memProc.running = true
    }
}
