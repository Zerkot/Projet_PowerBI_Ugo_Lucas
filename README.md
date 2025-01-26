# Projet Power BI - Analyse de Données ENEDIS

## Description
Ce repository contient les fichiers nécessaires à la création, l'analyse et la documentation d'un projet Power BI axé sur les données ENEDIS. L'objectif est d'optimiser les performances des rapports, d'exploiter un modèle de données étoilé et de fournir une documentation complète (technique et fonctionnelle).
Le tableau de bord est disponible en ligne : https://app.powerbi.com/groups/me/reports/d580f98c-bd7e-434e-8a61-e0b2e5f5029b/6d8c0fb3acdb58be7cc1?experience=power-bi Veuiller changer de navigateur si le lien ne marche pas.
---

## Contenu du repository

### 1. **Rapports et fichiers Power BI**
- **`DPE_PowerBI.pbix`** : Fichier Power BI contenant le modèle de données et les visualisations principales liées à l'analyse des données.
- **`PowerBIPerformance_ENEDIS.json`** : Fichier JSON contenant l'analyse des performances du rapport Power BI, utile pour identifier les goulots d'étranglement.

### 2. **Données**
- **`df_principale.xlsx`** : Fichier Excel contenant les données principales utilisées pour construire le modèle Power BI.
- **`Schemas en etoile.txt`** : Explications textuelles du schéma en étoile utilisé dans le modèle de données.

### 3. **Documentation**
- **`documentation technique.docx`** : Documentation technique détaillant la configuration, les sources de données, le modèle Power BI et les choix techniques.
- **`documentation fonctionnelle projet enedis.docx`** : Documentation fonctionnelle expliquant les objectifs du projet, les cas d'utilisation et les rapports.
- **`README.md`** : Ce fichier décrivant le repository.

### 4. **Scripts et outils**
- **`script_89.R`** : Script R utilisé pour pré-traiter et remplir  les données dans un fichier avant leur intégration dans Power BI.

### 5. **Organisation et tâches**
- **`TO_DO_LIST`** : Liste des tâches à accomplir pour le projet, mise à jour régulièrement.

---

## Organisation du Projet

### Modèle de Données
Le modèle utilise un **schéma en étoile**, optimisé pour les performances Power BI. Il est conçu pour minimiser les relations complexes et maximiser la vitesse d'exécution.

### Performance
L'analyse des performances a été réalisée à l'aide de l'outil d'enregistrement Power BI. Les détails sont disponibles dans le fichier `PowerBIPerformance_ENEDIS.json`.

---

## Instructions pour exécuter le projet

1. **Cloner le repository :**
   ```bash
   git clone [git@github.com:USERNAME/Projet_PowerBI.git](https://github.com/Zerkot/Projet_PowerBI.git)
Puis éxecuter le **`DPE_PowerBI.pbix`** pour modifier le rapport.
