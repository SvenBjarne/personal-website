import express from 'express';
import path from 'path';
import data from './text.json';

const app = express();
const port = 3000;

app.set('view engine', 'pug');
app.set('views', path.join(__dirname));
app.use(express.static(path.join(__dirname)));

app.get('/', (req, res) => { res.render('index', data); });
app.get('/articles', (req, res) => { res.render('articles', data); });
app.get('/about', (req, res) => { res.render('about', data); });

app.listen(port, () => {
  return console.log(`Express is listening at http://localhost:${port}`);
});