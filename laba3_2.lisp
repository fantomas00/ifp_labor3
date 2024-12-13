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



