#include "myimagemodel.h"

#include <QDir>
#include <QImageReader>
#include <iostream>

MyImageModel::MyImageModel(QObject* parent)
    :  QAbstractListModel(parent), m_images(std::vector<QString>())
{}

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

void MyImageModel::changeData(QString newPath){
    emit layoutAboutToBeChanged();

    m_images.clear();

    // convert path from qml path to normal
    const QUrl path(newPath);

    std::cout << path.toLocalFile().toStdString() << std::endl;
    loadImagesFromDir(path.toLocalFile());

    std::cout << m_images.size() << std::endl;
    emit layoutChanged();
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

void MyImageModel::loadImagesFromDir(QString dir){
    for(auto &i : QDir(dir).entryInfoList()){
        // determines whether qt can read the file as an image
        if(QImageReader::imageFormat(i.absoluteFilePath()) == ""){
            continue;
        }
        m_images.push_back(i.absoluteFilePath());
    }
}
