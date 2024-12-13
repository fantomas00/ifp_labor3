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
