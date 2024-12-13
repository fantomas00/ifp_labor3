
<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Конструктивний і деструктивний підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент</b>: Ольховський Максим Олександрович КВ-13</p>
<p align="right"><b>Рік</b>: 2024</p>

## Загальне завдання
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного списку. Не допускається використання: деструктивних операцій, циклів, функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і деструктивних функцій (псевдофункцій). Не допускається використання функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Тим не менш, оригінальний список цей варіант реалізації також не має змінювати, тому перед виконанням деструктивних змін варто застосувати функцію copy-list (в разі необхідності). Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).
## Варіант 4
Алгоритм сортування вставкою No2 (з лінійним пошуком справа) за незменшенням.
## Лістинг функції з використанням конструктивного підходу
```lisp
(defun insertion-sort-functional (lst)
  "Функціональне сортування вставкою зі стилем підфункцій."
  
  (labels ((insert (x sorted-list)
             "Вставляє елемент X у впорядкований список sorted-list."
             (cond
               ((null sorted-list) (list x))
               ((<= x (car sorted-list)) (cons x sorted-list))
               (t (cons (car sorted-list) (insert x (cdr sorted-list))))))

           (recursive-sort (unsorted sorted)
             "Рекурсивно сортує список, додаючи кожен елемент до відсортованого."
             (if (null unsorted)
                 sorted
                 (recursive-sort (cdr unsorted)
                                 (insert (car unsorted) sorted)))))

    (recursive-sort lst nil)))
```
### Тестові набори
```lisp
(defun check-insertion-sort (name lst expected)
  "Виконує `insertion-sort-functional` на `lst`, порівнює результат з `expected` і друкує статус."
  (format t "~:[FAILED~;passed~]... ~a~%" 
          (equal (insertion-sort-functional lst) expected)
          name))

(defun test-insertion-sort ()
  (check-insertion-sort "Test 1" '(3 1 4 1 5 9 2 6 5 3 5) '(1 1 2 3 3 4 5 5 5 6 9)) 
  (check-insertion-sort "Test 2" '(7 3 2 9 4) '(2 3 4 7 9))               
  (check-insertion-sort "Test 3" '(10 1 5 8 3) '(1 3 5 8 10))
  (check-insertion-sort "Test 4" '() '())
  (check-insertion-sort "Test 5" '(42) '(42))
  (check-insertion-sort "Test 6" '(5 4 3 2 1) '(1 2 3 4 5))
  (check-insertion-sort "Test 7" '(1 2 3 4 5) '(1 2 3 4 5))
  (check-insertion-sort "Test 8" '(1 -1 0 3 -3) '(-3 -1 0 1 3))
  (check-insertion-sort "Test 9" '(2 2 2 2) '(2 2 2 2))
  (check-insertion-sort "Test 10" '(100 99 98) '(98 99 100)))

CL-USER> (test-insertion-sort)
```
### Тестування
```lisp
passed... Test 1
passed... Test 2
passed... Test 3
passed... Test 4
passed... Test 5
passed... Test 6
passed... Test 7
passed... Test 8
passed... Test 9
passed... Test 10
```
## Лістинг функції з використанням деструктивного підходу
```lisp
(defun insertion-sort-imperative (lst)
  "Імперативне сортування вставкою зі збереженням початкового списку."
  (let ((copy (copy-list lst))) 
    (loop for i from 1 below (length copy) do
          (let ((key (nth i copy))
                (j (1- i))) 
            (loop while (and (>= j 0) (> (nth j copy) key)) do
                  (setf (nth (1+ j) copy) (nth j copy))
                  (decf j))
            (setf (nth (1+ j) copy) key)))
    copy))
```
### Тестові набори
```lisp
(defun check-insertion-sort (name lst expected)
  "Виконує `insertion-sort-imperative` на `lst`, порівнює результат з `expected` і друкує статус."
  (format t "~:[FAILED~;passed~]... ~a~%" 
          (equal (insertion-sort-imperative lst) expected)
          name))

(defun test-insertion-sort ()
  (check-insertion-sort "Test 1" '(3 1 4 1 5 9 2 6 5 3 5) '(1 1 2 3 3 4 5 5 5 6 9)) 
  (check-insertion-sort "Test 2" '(7 3 2 9 4) '(2 3 4 7 9))               
  (check-insertion-sort "Test 3" '(10 1 5 8 3) '(1 3 5 8 10))
  (check-insertion-sort "Test 4" '() '())
  (check-insertion-sort "Test 5" '(42) '(42))
  (check-insertion-sort "Test 6" '(5 4 3 2 1) '(1 2 3 4 5))
  (check-insertion-sort "Test 7" '(1 2 3 4 5) '(1 2 3 4 5))
  (check-insertion-sort "Test 8" '(1 -1 0 3 -3) '(-3 -1 0 1 3))
  (check-insertion-sort "Test 9" '(2 2 2 2) '(2 2 2 2))
  (check-insertion-sort "Test 10" '(100 99 98) '(98 99 100)))

CL-USER> (test-insertion-sort)
```
### Тестування
```lisp
passed... Test 1
passed... Test 2
passed... Test 3
passed... Test 4
passed... Test 5
passed... Test 6
passed... Test 7
passed... Test 8
passed... Test 9
passed... Test 10
```
