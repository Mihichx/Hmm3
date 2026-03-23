let system = (function() {
    let self;
    
    class System {
        constructor() {
            this.name = 'Системный модуль';
            this.version = '0.5';
            this.loading = false;
            this.reader = new FileReader();
            self = this;
            
            this.reader.onload = function() {
                self.loading = false;
            };
            this.reader.onerror = function() {
                self.loading = false;
            };
            
        }
        async request(url, data) {
            let formData = new FormData();
            for (let key in data) {
                formData.append(key, data[key]);
            }

            try {
                let response = await fetch(url, {
                    method: 'POST',
                    body: formData
                });

                if (response.ok) {
                    return await response.text(); // возвращаем текст (JSON), который потом распарсит DataType
                } else {
                    throw new Error('Ошибка сервера: ' + response.status);
                }
            } catch (error) {
                console.error('Ошибка запроса:', error);
                throw error;
            }
        }
        
        // сохранение файла
        save(code, name = 'map.txt') {
            let blob = new Blob([code], {type: 'text/plain'});
            let url = URL.createObjectURL(blob);
            self.link(name, url);
            return self;
        }
        
        // Создать ссылку, передать данные
        link(name, url) {
            let link = document.createElement('a');
            
            link.download = name;
            link.href = url;
            link.click();
            URL.revokeObjectURL(link.href);
            link = null;
            return self;
        }
        
        // создавать паузу выполнения
        async pause(miliseconds) {
            let promise = new Promise((resolve, reject) => {
                setTimeout(() => resolve("готово!"), miliseconds)
            });
            
            let result = await promise; 
            return result;
        }
        
        // вешаем обработчик загрузки файлов
        load(selector, handler) {
            document.querySelector(selector).addEventListener('change', function(e) {
                self.loadFile(e.target, handler);
            });
        }
        
        loadFile(input, handler) {
            let file = input.files[0];
            input.value = '';
            self.readFile(file).then(handler);
        }
        
        fileInfo(file) {
            return "Loaded file: " + file.name + ", Size: " + file.size + " bytes";
        }
        
        // загрузка файла - промисификация вместо активного ожидания
        readFile(file) {
            return new Promise((resolve, reject) => {
                const reader = new FileReader();
                
                reader.onload = () => resolve(reader);
                reader.onerror = () => reject(new Error('File read failed'));
                reader.onabort = () => reject(new Error('File read aborted'));
                
                reader.readAsText(file);
            });
        }
    }
    // Erid Nord
    return new System();
})();
