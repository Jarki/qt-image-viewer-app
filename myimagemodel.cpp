#include "myimagemodel.h"

#include <QDir>
#include <QImageReader>
#include <iostream>

MyImageModel::MyImageModel(QObject* parent)
    :  QAbstractListModel(parent)
{
    QString path = "D:\\images_example\\testing_example";

    for(auto &i : QDir(path).entryInfoList()){
        // determines whether qt can read the file as an image
        if(QImageReader::imageFormat(i.absoluteFilePath()) == ""){
            continue;
        }
        m_images.push_back(i.absoluteFilePath());
        std::cout << i.absoluteFilePath().toStdString() << std::endl;
    }
}

QVariant MyImageModel::data(const QModelIndex& index, int role) const
{
    const size_t row = static_cast<size_t>(index.row());
    if ( !index.isValid() || index.row() < 0 || row >= m_images.size() )
    {
        return QVariant();
    }
    const QString modelEntry = m_images[row];
    if (role == ImagePathRole)
    {
        return modelEntry;
    }
    return QVariant();
}

int MyImageModel::rowCount(const QModelIndex& /*parent*/) const
{
    return static_cast<int>(m_images.size());
}

QHash<int, QByteArray> MyImageModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ImagePathRole] = "imagePathRole";
    return roles;
}
