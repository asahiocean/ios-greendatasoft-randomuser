<h2>Тестовое задание iOS-разработчик<img src="https://tinyurl.com/yckhw7cw" align="right" /></h2>

<p><strong>Необходимо реализовать онлайн записную книжку, состоящую из не реальных людей, используя <a href="https://randomuser.me">randomuser.me</a></strong></p>

<p>
<code>При отсутствии интернета используем ранее сохраненные данные из БД.</code>
</p>

<h2>Первый экран:</h2>

<ul>
<li>Список с подзагрузкой из кастомных ячеек, где отображается фотография пользователя и имя</li>
<li>Если проскролили до момента, где записи кончились, то подзагружаем еще до бесконечности</li>
<li>Загружаемые данные пишем в БД</li>
<li>Фотографии должны грузится параллельно и сохраняться в кеше</li>
</ul>

<h2>Второй экран:</h2>

<p><strong>При нажатии на ячейку на первом экране открываем профиль человека</strong></p>
<p><strong>В профиле человека должны быть следующие данные:</strong></p>

<ul>
<li>Фотография (с возможностью открытия на полный экран) * Имя Фамилия * Пол (в виде иконки)</li>
<li>Дата рождения в виде ДД.ММ.ГГГГ (в скобках число лет)</li>
<li>Почта</li>
<li>Местное время (текущее время + смещение по часовому поясу)</li>
</ul>

<h2>Условия</h2>

<p>Требуемый язык программирования: Swift</p>
<p><code>Api с пагинацией для загрузки: <a href="https://randomuser.me/documentation#pagination">https://randomuser.me/documentation#pagination</a></code></p>
<p><strong>Вариант реализации ничем не ограничен, плюсом будет использование следующего стека: </strong></p>

<ul>
<li>CoreData</li>
<li>SimpleImageViewer (pod)</li>
<li>EGOCache (pod)</li>
<li>FontAwesome</li>
</ul>

<h2>Превью</h2>

<p><img src="https://media.giphy.com/media/Ppq8c1rCq8iy0tcesx/giphy.gif" /></p>

<hr>

<blockquote>
<b>Disclaimer:</b> By using any content from this repository, you release the author(s) from all liability and warranty of any kind. You are free to use the content freely and as you see fit. Any suggestions for improvement are welcome and greatly appreciated! Happy coding!
</blockquote>
