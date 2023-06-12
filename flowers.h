#ifndef FLOWERS_H
#define FLOWERS_H

#include <QObject>
#include <QFile>
#include <QStandardPaths>
#include <QVector>
struct Flower
{
    QString name; // наименование цветка
    QString path; // путь до изображения цветка
    unsigned short price; // цена цветка
};
struct Order
{
    QString name;
    unsigned short price; // стоимость цветов
    unsigned short number; // количество цветов
};
struct Pack // Готовый заказ
{
    QString info; // время + контрольная сумма
    unsigned char position; // новый, собранный, завершённый
    QString orderList; // чек
};

class Flowers : public QObject
{
    Q_OBJECT
    static const QString pathToThefolder;
    QVector<Flower> vec; // доступные позиции (цветы)
    QVector<Order> order; // выбранные позиции (чек)
    QVector<Pack> orders_all; // массив заказов (чеков)
    unsigned short getPackNumber(unsigned short i, unsigned char p) const;
public:
    explicit Flowers(QObject *parent = nullptr);
public slots:
    void setOrder(const unsigned short i);
    void setOrderNumber(unsigned short i, const short val);

    QString getPath(unsigned short i) const { return vec[i].path; }
    QString getName(unsigned short i) const { return vec[i].name; }
    unsigned short getPrice(unsigned short i)  const { return vec[i].price; }
    unsigned short getSize() const { return vec.size(); }
    unsigned short getOrderSize() const {return order.size();}
    QString getOrderName(unsigned short i) const { return order[i].name;}
    unsigned short getOrderNumber(unsigned short i) const { return order[i].number;}
    unsigned short getOrderPrice(unsigned short i) const {return order[i].price;}

    void clearBucket() {for(auto i = order.size() - 1 ; i >= 0 ; i--) order.removeAt(i);}

    unsigned short findFlowers(QString name);

    void endOrder(); // Записываем текущий чек в массив чеков, после освобождаем текущий чек

    unsigned short getPackSize(unsigned char p) const;
    // Время +  цена
    QString getPackInfo(unsigned short i, unsigned char p) const {int j = getPackNumber(i, p);return orders_all[j].info;}
    // Чек
    QString getOrderList(unsigned short i, unsigned char p) const {int j = getPackNumber(i, p);return orders_all[j].orderList;}
    // Переместить заказа в (новые, собранные, завершённые)
    void setPackPosition(unsigned short i, unsigned char p1, unsigned char p2) {int j = getPackNumber(i, p1); orders_all[j].position = p2;};
    // Удалить заказ из календаря
    void deletePack(unsigned short i, unsigned char p) {int j = getPackNumber(i, p); orders_all.removeAt(j);}
};

#endif // FLOWERS_H
