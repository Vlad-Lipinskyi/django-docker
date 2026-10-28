# django-docker
# practice-terraform
Terraform-проєкт створює базову інфраструктуру в AWS для зберігання Terraform state, роботи мережі та зберігання Docker-образів.
# Структура проєкту
- main.tf — підключає модулі S3/DynamoDB, VPC та ECR.
- `backend.tf — містить конфігурацію AWS-провайдера та S3 backend.
- variables.tf — задає регіон, CIDR-діапазони, назви ресурсів і Availability Zones.
- outputs.tf — виводить назви й ідентифікатори створених ресурсів.
- modules/ — окремі Terraform-модулі для кожної частини інфраструктури.

# S3 backend (`modules/s3-backend`)
Створює S3-бакет для файлу Terraform state та вмикає версіонування. Також створює DynamoDB-таблицю з ключем `LockID`, яка використовується для блокування state під час одночасної роботи

# ECR (`modules/ecr`)
Створює репозиторій Amazon Elastic Container Registry для Docker-образів. Для завантажених образів увімкнене автоматичне сканування, а політика доступу налаштована для AWS-акаунта, у якому створено репозиторій.

# Вихідні дані
Після застосування конфігурації Terraform виводить назву S3-бакета, DynamoDB-таблиці, ID VPC і підмереж, а також URL ECR-репозиторію.

# Команди Terraform
sh
terraform init
terraform plan
terraform apply
terraform destroy


- terraform init — ініціалізує Terraform і завантажує AWS-провайдер
- terraform plan — показує, які ресурси буде створено, змінено або видалено
- terraform apply — застосовує конфігурацію та створює ресурси в AWS
- terraform destroy` — видаляє ресурси, керовані цим проєктом
