#include "tcpclient.h"

tcpServerReceive::tcpServerReceive(QObject *parent)
    : QObject{parent}
{
    connect(&server, &QTcpServer::newConnection, this, &tcpServerReceive::onNewConnection);
}

bool tcpServerReceive::startServer(quint16 port)
{
    if (!server.listen(QHostAddress::Any, port)) {
        return false;
    }
    return true;
}

void tcpServerReceive::stopServer()
{
    server.close();
    for (QTcpSocket *socket : qAsConst(clientSockets)) {
        socket->close();
        socket->deleteLater();
    }
    clientSockets.clear();
}

void tcpServerReceive::onNewConnection()
{
    QTcpSocket *newClient = server.nextPendingConnection();
    if (newClient) {
        clientSockets.append(newClient);
        connect(newClient, &QTcpSocket::readyRead, this, &tcpServerReceive::onReadyRead);
    }
}

void tcpServerReceive::onReadyRead()
{
    int values_count = 4;
    int car_speed;
    int car_RMP;
    int car_fuel;
    int car_temp;

    for (QTcpSocket *socket : qAsConst(clientSockets)) {
        QByteArray data = socket->read(values_count * sizeof(int));
        QDataStream stream(&data, QIODevice::ReadOnly);

        // Read the data into respective lists
        for (int i = 0; i < values_count; ++i) {
            int value;
            stream >> value;
            qDebug() << value;
        }
    }

    // qDebug() << "Received car_speed:" << car_speed;
    // qDebug() << "Received car_temp:" << car_temp;
    // qDebug() << "Received car_RMP:" << car_RMP;
    // qDebug() << "Received car_fuel:" << car_fuel;

    // Emit the signal with the parsed lists
    // emit messageReceived(car_speed, car_temp, car_RMP, car_fuel);
}

void tcpServerReceive::printLists(const QList<double>& list) {
    for (const auto& value : list) {
        qDebug() << value;
    }
}



