#include "flowers.h"
#include <QDebug>
#include <QTime>
#include <QDate>
Flowers::Flowers(QObject *parent) : QObject(parent)
{
    QFile file(pathToThefolder + "/database.txt");
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
        qDebug() << "the file wasn't found";
    while(!file.atEnd()){
        QString name = QString::fromLocal8Bit(file.readLine().simplified());
        QString path = pathToThefolder+"/"+name+".jpg";
        unsigned short price = file.readLine().toInt();
        Flower obj = {
            name.replace("_", " "),
            path,
            price
        };
        vec.append(obj);
    }
}

void Flowers::setOrder(const unsigned short i) { 
    Order obj = {vec[i].name, vec[i].price, 1};
    if(order.size() == 0) {order.append(obj); return;}
    for(int j = 0; j < order.size(); j++)
        if(order[j].name == vec[i].name) return;
    order.append(obj);
}

void Flowers::setOrderNumber(unsigned short i, const short val)
{

    order[i].number += val;
    if(order[i].number == 0)
        order.removeAt(i);
    else
        for(auto j = 0; j < vec.size(); j++)
            if(vec[j].name == order[i].name)
                order[i].price = order[i].number * vec[j].price;
}

unsigned short Flowers::findFlowers(QString name)
{
    unsigned short num = 0;
    for(auto i = 0; i < vec.size(); i++)
        if(name == vec[i].name) return num;
    return 0;
}

void Flowers::endOrder()
{
    Pack pack;
    QString time = QDate::currentDate().toString("dd/MM/yy") + '\n' + QTime::currentTime().toString("hh:mm");
    unsigned short price = 0;
    pack.position = 0;
    for(auto i = 0; i < order.size(); i++)
    {
        price+=order[i].price;
        pack.orderList+=order[i].name + " (" + QString::number(order[i].number) +
                "шт): " + QString::number(order[i].price) + "р\n";
    }
    pack.info = time + "\n\n" + QString::number(price);
    orders_all.append(pack);
    clearBucket(); // Освобождаем текущий чек
}

unsigned short Flowers::getPackSize(unsigned char p) const
{
    unsigned short count = 0;
    for(auto i = 0; i < orders_all.size(); i++)
        if(orders_all[i].position == p)
            count++;
    return count;
}
unsigned short Flowers::getPackNumber(unsigned short i, unsigned char p) const
{
    unsigned short count = 0;
    for(auto j = 0; j < orders_all.size(); j++)
        if(orders_all[j].position == p)
        {
            if(count == i) {
                return j;
                break;
            }
            count++;
        }
    return 0;
}

const QString Flowers::pathToThefolder = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation)+"/Flowers";


