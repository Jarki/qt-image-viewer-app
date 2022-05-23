#ifndef MYIMAGEMODEL_H
#define MYIMAGEMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <vector>

enum DataRoles
{
    ImagePathRole = Qt::UserRole + 1
};

class MyImageModel : public QAbstractListModel
{
    Q_OBJECT
public:
    MyImageModel(QObject* parent = nullptr);
    Q_INVOKABLE virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE virtual int rowCount(const QModelIndex &parent) const override;
    virtual QHash<int,QByteArray> roleNames() const override;

public slots:
    void changeData(QString newPath);
signals:

private:
    void loadImagesFromDir(QString dir);

    std::vector<QString> m_images;
};

#endif // MYIMAGEMODEL_H
