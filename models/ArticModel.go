package models

import (
	// "github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	// _ "github.com/mattn/go-sqlite3"
	// "strconv"
	// "strings"
	"time"
)

type Article struct {
	Id        int64     `json:"id",form:"-"`
	Subtext   string    `orm:"sie(20)"`
	Content   string    `json:"html",orm:"sie(5000)"`
	ProductId int64     `orm:"null"`
	CateId int64     `orm:"null"`
	Views     int64     `orm:"default(0)"`
	Created   time.Time `orm:"auto_now_add;type(datetime)"`
	Updated   time.Time `orm:"auto_now_add;type(datetime)"`
	Uid          int64  `orm:"null"`
}


//分类
type ArticleCate struct {
	Id       int64     `form:"-"`
	ParentId int64     `orm:"null"`
	Name    string    	`orm:"size(255)"`
	Created  time.Time `orm:"auto_now_add;type(datetime)"`
	Updated  time.Time `orm:"auto_now_add;type(datetime)"`
}



func init() {
	orm.RegisterModel(new(Article),new(ArticleCate)) //, new(Article)
	// orm.RegisterDriver("sqlite", orm.DRSqlite)
	// orm.RegisterDataBase("default", "sqlite3", "database/engineer.db", 10)
}

//添加文章作为成果的附件  文章添加摘出来写
func AddArticle(subtext, content string, uid int64,cateId int64) (id int64, err error) {
	o := orm.NewOrm()
	Article := &Article{
		Subtext:   subtext,
		Content:   content,
		Uid: uid,
		CateId: cateId,
		Created:   time.Now(),
		Updated:   time.Now(),
	}
	id, err = o.Insert(Article)
	if err != nil {
		return 0, err
	}
	return id, nil
}

//修改
func UpdateArticle(id int64, subtext, content string) error {
	o := orm.NewOrm()
	article := &Article{Id: id}
	if o.Read(article) == nil {
		article.Subtext = subtext
		article.Content = content
		article.Updated = time.Now()
		_, err := o.Update(article)
		if err != nil {
			return err
		}
	}
	return nil
}

//删除
func DeleteArticle(id int64) error {
	o := orm.NewOrm()
	article := &Article{Id: id}
	if o.Read(article) == nil {
		_, err := o.Delete(article)
		if err != nil {
			return err
		}
	}
	return nil
}
//批量删除
func DelArticle(ids []int) error {
	var Articles []*Article
	o := orm.NewOrm()
	qs := o.QueryTable("Article")


	qs.Filter("id__in",ids).All(&Articles, "Id", "CateId", "Created", "Updated")

	if len(Articles) != 0 {
		_, err := qs.Filter("id__in",ids).Delete()
		if err != nil {
			return err
		}
	}

	return nil
}

func CheckArticle(ids []int,uid int64) bool {
	var Articles []*Article
	o := orm.NewOrm()
	qs := o.QueryTable("Article")

	qs.Filter("id__in",ids).All(&Articles, "Id", "CateId", "Created", "Updated")


	count, err := qs.Filter("id__in", ids).Exclude("uid", uid).Count()
	// WHERE profile.age IN (18, 20) AND NOT profile_id < 1000
	if err != nil {
		return false
	}

	if count > 0 {
		return false
	}

	return true
}

//取得所有项目
// func GetArticles() (Artic []*Article, err error) {
// 	o := orm.NewOrm()
// 	qs := o.QueryTable("Article") //这个表名AchievementTopic需要用驼峰式，
// 	_, err = qs.Filter("parentid", 0).All(&Artic)
// 	if err != nil {
// 		return Artic, err
// 	}
// 	return Artic, err
// }
//根据成果id取得所有文章——只返回id和prodid，因为返回content太慢了，没必要吧20171007
func GetArticles(pid int64) (Articles []*Article, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable("Article")
	//_, err = qs.Filter("Productid", pid).All(&Articles, "Id", "ProductId", "Created", "Updated")

	if pid != 0 {
		_, err = qs.Filter("CateId", pid).All(&Articles, "Id", "CateId", "Created", "Updated")
	} else {
		_, err = qs.All(&Articles, "Id", "CateId", "Created", "Updated")
	}

	if err != nil {
		return nil, err
	}


	return Articles, err
}

//微信小程序，根据成果id取得所有文章——返回id和prodid，content……
func GetWxArticles(pid int64) (Articles []*Article, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable("Article")
	_, err = qs.Filter("Productid", pid).All(&Articles)
	if err != nil {
		return nil, err
	}
	return Articles, err
}

//根据文章id取得文章
func GetArticle(id int64) (Artic *Article, err error) {
	o := orm.NewOrm()
	article := new(Article)
	qs := o.QueryTable("Article") //这个表名AchievementTopic需要用驼峰式，
	err = qs.Filter("id", id).One(article)
	if err != nil {
		return Artic, err
	}

	article.Views++
	_, err = o.Update(article)
	if err != nil {
		return article, err
	}

	return article, err
}


func GetArticleCate(pid int64) (departs []*ArticleCate, err error) {
	o := orm.NewOrm()
	departs = make([]*ArticleCate, 0)
	qs := o.QueryTable("ArticleCate")
	_, err = qs.Filter("parent_id", pid).All(&departs)
	if err != nil {
		return nil, err
	}
	return departs, err
}


func GetArticleCateId(id int64) (categories []*ArticleCate, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable("ArticleCate")
	var cate ArticleCate
	err = qs.Filter("id", id).One(&cate)
	categories = make([]*ArticleCate, 0)
	_, err = qs.Filter("parent_id", cate.Id).All(&categories)
	if err != nil {
		return nil, err
	}
	return categories, err
}



//添加部门
func AddArticleCate(pid int64, name string) (id int64, err error) {
	o := orm.NewOrm()
	cate := &ArticleCate{
		ParentId:pid,
		Name:name,
		Created:time.Now(),
		Updated:time.Now(),
	}
	id, err = o.Insert(cate)
	if err != nil {
		return 0, err
	}
	return id, nil
}

//修改
func UpdateArticleCate(cid int64, title string) error {
	o := orm.NewOrm()
	articlecate := &ArticleCate{Id: cid}
	if o.Read(articlecate) == nil {
		articlecate.Name = title
		articlecate.Updated = time.Now()
		_, err := o.Update(articlecate)
		if err != nil {
			return err
		}
	}
	return nil
}

//删除
func DeleteArticleCate(cid int64) error {
	o := orm.NewOrm()
	category := &ArticleCate{Id: cid}
	if o.Read(category) == nil {
		_, err := o.Delete(category)
		if err != nil {
			return err
		}
	}
	return nil
}


func GetCate(id int64) (prod ArticleCate, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable("ArticleCate") //这个表名AchievementTopic需要用驼峰式，
	err = qs.Filter("id", id).One(&prod)
	if err != nil {
		return prod, err
	}
	return prod, err
}


func GetCates(id int64) (prod []ArticleCate, err error) {
	o := orm.NewOrm()
	qs := o.QueryTable("ArticleCate") //这个表名AchievementTopic需要用驼峰式，
	if id == 0 {
		_,err = qs.Filter("parent_id",0).All(&prod)
	} else {
		_,err = qs.Filter("parent_id",id).All(&prod)
	}

	if err != nil {
		return prod, err
	}
	return prod, err
}






//根据侧栏id分页查出所有成果——按编号排序
func GetArticlesPage(id, limit, offset, uid int64, searchText string) (products []*Article, err error) {

	//ids:=[]int{17,18,19,20}
	//qs.Filter("age__in", ids)
	var ids []int

	cates,err := GetCates(id)
	if len(cates) == 0 {
		ids = append(ids, int(id))

	} else {
		for _, i := range cates {
			ids = append(ids, int(i.Id))
		}
	}




	o := orm.NewOrm()
	qs := o.QueryTable("Article")
	if searchText != "" {
		cond := orm.NewCondition()
		cond1 := cond.Or("Subtext__contains", searchText)
		cond3 := cond.Or("CateId__in", ids)
		cond2 := cond.AndCond(cond1).AndCond(cond3)
		if id == 0 {
			cond2 = cond.AndCond(cond1)
		}
		qs = qs.SetCond(cond2)
		_, err = qs.Limit(limit, offset).OrderBy("-created").All(&products)
	} else if uid == 0 {
		if id == 0 {
			_, err = qs.Limit(limit, offset).OrderBy("-created").All(&products)
		} else {

			cond := orm.NewCondition()
			cond3 := cond.Or("CateId__in", ids)
			qs = qs.SetCond(cond3)

			_, err = qs.Limit(limit, offset).OrderBy("-created").All(&products)
		}

	} else if uid != 0 {
		if id == 0 {
			_, err = qs.Filter("Uid", uid).Limit(limit, offset).OrderBy("-created").All(&products)
		} else {

			cond := orm.NewCondition()
			cond3 := cond.Or("CateId__in", ids)
			qs = qs.SetCond(cond3)
			_, err = qs.Filter("Uid", uid).Limit(limit, offset).OrderBy("-created").All(&products)
		}
	}
	return products, err
}


//取得侧栏id下成果总数
func GetArticlesCount(id int64, searchText string) (count int64, err error) {

	var ids []int

	cates,err := GetCates(id)
	if len(cates) == 0 {
		ids = append(ids, int(id))

	} else {
		for _, i := range cates {
			ids = append(ids, int(i.Id))
		}
	}





	o := orm.NewOrm()
	qs := o.QueryTable("Article")
	if searchText != "" {
		cond := orm.NewCondition()
		cond1 := cond.Or("Subtext__contains", searchText)
		cond3 := cond.Or("CateId__in", ids)
		cond2 := cond.AndCond(cond1).AndCond(cond3)
		if id == 0 {
			cond2 = cond.AndCond(cond1)
		}
		qs = qs.SetCond(cond2)
		count, err = qs.Limit(-1).Count()
	} else {
		if id == 0  {
			count, err = qs.Count()
		} else {
			cond := orm.NewCondition()
			cond3 := cond.Or("CateId__in", ids)
			qs = qs.SetCond(cond3)
			count, err = qs.Count()
		}
	}
	return count, err
}